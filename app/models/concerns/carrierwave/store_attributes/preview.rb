# Dieses Modul kümmert sich darum, dass, sofern das Attribut
# hash_tags vorhanden ist, dieses entsprechend formatiert wird.
#
module Carrierwave
  module StoreAttributes
    module Preview
      extend ActiveSupport::Concern

      included do
        field :preview_content_type,
              type: String

        field :preview_extension,
              type: String

        field :preview_file_size,
              type: Integer

        field :preview_file_name,
              type: String

        process_in_background :preview
        field :preview_processing,
              type: Boolean,
              default: false
      end

      def self.included(base)
        base.before_save :_update_preview_attributes
      end

      private

      def _update_preview_attributes
        if self.class.method_defined?(:preview)
          if preview.present? && preview_changed?
            self.preview_file_name = preview.file.filename
            self.preview_content_type = preview.file.content_type
            self.preview_file_size = preview.file.size
            self.preview_file_name = self[:preview]
          end
        end
      end
    end
  end
end