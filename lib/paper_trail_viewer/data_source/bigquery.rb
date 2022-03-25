module PaperTrailViewer::DataSource
  class Bigquery
    def initialize(project_id:, credentials:, table:)
      require 'google/cloud/bigquery'

      @bigquery = Google::Cloud::Bigquery.new(
        project_id:  project_id,
        credentials: credentials,
      )
      @table = table
    end

    def call(item_type: nil, item_id: nil, event: nil, filter: nil, page: 1, per_page: 50)
      # https://cloud.google.com/bigquery/docs/reference/standard-sql/query-syntax
      bigquery_result = @bigquery.query(<<~SQL, max: per_page)
        SELECT   *
        FROM     `#{@table}`
        # Ignore blank versions that only touch updated_at or untracked fields.
        WHERE    object_changes != ''
        #{"AND   item_type = '#{item_type}'"        if item_type.present?}
        #{"AND   item_id = #{item_id}"              if item_id.present?}
        #{"AND   event = '#{event}'"                if event.present?}
        #{"AND   object_changes LIKE '%#{filter}%'" if filter.present?}
        ORDER BY created_at DESC, id DESC
        # Paginate via OFFSET.
        # LIMIT must be greater than `max:` or result#next? is always false.
        LIMIT    #{per_page + 1} OFFSET #{(page - 1) * per_page}
      SQL

      Adapter.new(bigquery_result)
    end

    Adapter = Struct.new(:bigquery_result) do
      # PaperTrail::Version::ActiveRecord_Relation compatibility method
      def map
        bigquery_result.map { |row| yield PaperTrail::Version.new(row) }
      end

      # Kaminari compatibility method
      def last_page?
        !bigquery_result.next?
      end
    end
  end
end
