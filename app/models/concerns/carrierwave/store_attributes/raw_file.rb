# Dieses Modul kümmert sich darum, dass, sofern das Attribut
# :raw_file vorhanden ist, dieses entsprechend formatiert wird.
#
module Carrierwave
  module StoreAttributes
    module RawFile
      extend ActiveSupport::Concern

      included do
        field :raw_file_content_type,
              type: String

        field :raw_file_extension,
              type: String

        field :raw_file_file_size,
              type: Integer

        field :raw_file_file_name,
              type: String

        # field :raw_file_processing,
        #       type: Boolean,
        #       default: false
      end

      def self.included(base)
        base.before_save :_update_raw_file_attributes
      end

      private

      def _update_raw_file_attributes
        if self.class.method_defined?(:raw_file)
          if raw_file.present? && raw_file_changed?
            self.raw_file_file_name = raw_file.file.filename
            self.raw_file_extension = raw_file.file.extension.downcase
            self.raw_file_content_type = raw_file.file.content_type
            self.raw_file_file_size = raw_file.file.size
          end
        end
      end
    end
  end
end
