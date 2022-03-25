class PaperTrailViewer::VersionsController < ActionController::Base
  # Return the queried versions as JSON.
  def index
    query = sanitized_params
    versions = PaperTrailViewer.data_source.call(**query)
    versions_as_json = versions.map { |v| version_as_json(v) }

    render json: {
      hasNextPage: !versions.last_page? && versions_as_json.any?,
      query:       query,
      versions:    versions_as_json,
    }
  end

  # Rollback a change
  def update
    unless version = PaperTrail::Version.find_by(id: params[:id])
      flash[:error] = 'No such version.'
      return redirect_to(root_url)
    end

    result =
      if version.event == 'create'
        version.item_type.constantize.find(version.item_id).destroy
      else
        version.reify.save
      end

    if result
      if version.event == 'create'
        flash[:notice] = 'Rolled back newly-created record by destroying it.'
        redirect_to root_url
      else
        flash[:notice] = 'Rolled back changes to this record.'
        redirect_to change_item_url(version)
      end
    else
      flash[:error] = "Couldn't rollback. Sorry."
      redirect_to root_url
    end
  end

  private

  def sanitized_params
    {
      event:     params[:event].presence_in(%w[create update destroy]),
      filter:    (params[:filter].presence if params[:filter] != '%%'),
      item_id:   params[:item_id].presence,
      item_type: params[:item_type].presence,
      page:      (page = params[:page].to_i) > 0 ? page : 1,
      per_page:  (per = params[:per_page].to_i).clamp(1, 1000),
    }
  end

  def version_as_json(version)
    {
      **version.attributes.slice(*%w[id whodunnit event created_at]),
      changeset: changeset_for(version),
      object:    load_object(version),
      item_id:   version.item_id.to_s,
      item_type: version.item_type,
      item_url:  change_item_url(version),
      user_url:  user_url(version),
    }
  end

  def changeset_for(version)
    case version.event
    when 'create', 'update'
      version.changeset || {}
    when 'destroy'
      record = version.reify rescue nil
      return {} unless record

      record.attributes.each_with_object({}) do |changes, (k, v)|
        changes[k] = [v, nil] unless v.nil?
      end
    else
      raise ArgumentError, "Unknown event: #{version.event}"
    end
  end

  # Return the URL for the item represented by the +version+,
  # e.g. a Company record instance referenced by a version.
  def change_item_url(version)
    version_type = version.item_type.underscore.split('/').last
    main_app.try("#{version_type}_url", version.item_id)
  end

  def user_url(version)
    (path_method = PaperTrailViewer.user_path_method).present? &&
      (id = version.whodunnit).present? &&
      !id.start_with?('#') &&
      main_app.try(path_method, id) ||
      nil
  end

  def load_object(version)
    obj = version.object
    if obj.is_a?(String)
      PaperTrail.serializer.load(obj)
    elsif obj.is_a?(Hash)
      OpenStruct.new(obj)
    else
      obj
    end
  end
end

# backport deserialization fix for recent rubies
# https://github.com/paper-trail-gem/paper_trail/pull/1338
if PaperTrail::VERSION.to_s < '12.2.0'
  module PaperTrail::Serializers::YAML
    def load(string)
      ::YAML.respond_to?(:unsafe_load) ? ::YAML.unsafe_load(string) : ::YAML.load(string)
    end
  end
end
