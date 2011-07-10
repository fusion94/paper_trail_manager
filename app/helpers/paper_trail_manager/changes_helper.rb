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

    # Return an hash of changes for the given +Version+ record. The resulting
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
      changes = {}
      current = version.next.try(:reify)
      # FIXME #reify randomly throws "ArgumentError Exception: syntax error on line 13, col 30:" -- why?
      previous = version.reify rescue nil
      record = \
        begin
          version.item_type.constantize.find(version.item_id)
        rescue ActiveRecord::RecordNotFound
          previous || current
        end

      # Bail out if no changes are available
      return changes unless record

      case version.event
      when "create", "update"
        current ||= record
      when "destroy"
        previous ||= record
      else
        raise ArgumentError, "Unknown event: #{version.event}"
      end

      (current or previous).attribute_names.each do |name|
        next if name == "updated_at"
        next if name == "created_at"
        current_value = current.read_attribute(name) if current
        previous_value = previous.read_attribute(name) if previous
        unless current_value == previous_value || (version.event == "create" && current_value.blank?)
          changes[name] = {
            :previous => previous_value,
            :current => current_value,
          }
        end
      end

      return changes
    end

    # Returns string title for the versioned record.
    def change_title_for(version)
      current = version.next.try(:reify)
      previous = version.reify rescue nil
      record = version.item_type.constantize.find(version.item_id) rescue nil

      name = nil
      [:name, :title, :to_s].each do |name_method|
        [previous, current, record].each do |obj|
          name = obj.send(name_method) if obj.respond_to?(name_method)
          break if name
        end
        break if name
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
  end
end
