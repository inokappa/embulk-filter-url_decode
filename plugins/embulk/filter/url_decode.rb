# require 'pry'
# require 'pry-nav'
require 'cgi'

module Embulk
  module Filter
    class UrlDecodeFilterPlugin < FilterPlugin
      Plugin.register_filter('url_decode', self)

      def self.transaction(config, in_schema, &control)
        task = {
          'columns' => config.param('columns', :array, default: [])
        }

        yield(task, in_schema)
      end

      def initialize(task, in_schema, out_schema, page_builder)
        super
        @columns = task['columns']
      end

      def close
      end

      def add(page)
        page.each do |record|
          begin
            record = hash_record(record)

            @columns.each do |c| 
              decoded = ""
              decoded = decode_string(record[c]) if record[c] != ""
              record[c] = decoded
            end
            @page_builder.add(record.values)
          rescue
          end
        end
      end

      def finish
        @page_builder.finish
      end

      def hash_record(record)
        Hash[in_schema.names.zip(record)]
      end

      def decode_string(value)
        CGI.unescape(value)
      end
    end
  end
end
