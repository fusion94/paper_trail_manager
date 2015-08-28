class PaperTrailManager
  module ChangesHelper
    # Return HTML representing the +object+, which is either its text or a stylized "nil".
    def text_or_nil(object)
      if object.nil?
        return content_tag("em", "nil")
      else
        return h(object)
      end
    end

    # Return an hash of changes for the given +PaperTrail::Version+ record. The resulting
    # data structure is a hash whose keys are the names of changed columns and
    # values containing a hash with current and previous value. E.g.,:
    #
    #   {
    #     "my_column_name" => {
    #       :previous => "past value",
    #       :current  => "current_value",
    #     },
    #     "title" => {
    #       :previous => "puppies",
    #       :current  => "kittens",
    #     },
    #     ...
    #   }
    def changes_for(version)
      case version.event
      when "create", "update"
        return {} unless version.changeset
        version.changeset.inject({}) do |changes, (attr, (prev, curr))|
          changes.store(attr, {previous: prev, current: curr}) && changes
        end
      when "destroy"
        record = version_reify(version)
        return {} unless record
        record.attributes.reject{|k,v| v.nil?}.inject({}) do |changes, (attr, value)|
          changes.store(attr, {previous: value, current: nil}) && changes
        end
      else
        raise ArgumentError, "Unknown event: #{version.event}"
      end
    end

    # Returns string title for the versioned record.
    def change_title_for(version)
      if PaperTrailManager.item_name_method
        record = version_reify(version) || version.next.try(:reify) || version.item
        name = record.send(PaperTrailManager.item_name_method)
      else
        name = "#{version.item_type} #{version.item_id}"
      end

      return h(name)
    end

    # Returns sorted array of types of items that there are changes for.
    def change_item_types
      return ActiveRecord::Base.connection.select_values('SELECT DISTINCT(item_type) FROM versions ORDER BY item_type')
    end

    # Returns HTML link for the item stored in the version, e.g. a link to a Company record stored in the version.
    def change_item_link(version)
      if url = change_item_url(version)
        return link_to(change_title_for(version), url, :class => 'change_item')
      else
        return content_tag(:span, change_title_for(version), :class => 'change_item')
      end
    end

    def version_reify(version)
      version.reify
    rescue ArgumentError
      nil
    end
  end
end
