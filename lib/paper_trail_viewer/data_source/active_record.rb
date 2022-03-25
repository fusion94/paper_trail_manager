require 'kaminari'

module PaperTrailViewer::DataSource
  # The default data source. Queries version records via ActiveRecord.
  # See DataSource::Bigquery::Adapter for how to implement another source.
  class ActiveRecord
    def initialize(model: 'PaperTrail::Version')
      @model = model
    end

    def call(item_type: nil, item_id: nil, event: nil, filter: nil, page: 1, per_page: 50)
      versions = @model.is_a?(String) ? @model.constantize : @model
      versions = versions.order('created_at DESC, id DESC')

      if 'object_changes'.in?(versions.column_names)
        # Ignore blank versions that only touch updated_at or untracked fields.
        versions = versions.where.not(object_changes: '')
        versions = versions.where('object_changes LIKE ?', "%#{filter}%") if filter.present?
      elsif 'object'.in?(versions.column_names)
        versions = versions.where('object LIKE ?', "%#{filter}%") if filter.present?
      end

      versions = versions.where(item_type: item_type) if item_type.present?
      versions = versions.where(item_id: item_id) if item_id.present?
      versions = versions.where(event: event) if event.present?

      versions.page(page).per(per_page)
    end
  end
end
