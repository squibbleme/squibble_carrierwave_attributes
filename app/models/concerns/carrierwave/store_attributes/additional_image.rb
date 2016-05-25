# Dieses Modul kümmert sich darum, dass, sofern das Attribut
# hash_tags vorhanden ist, dieses entsprechend formatiert wird.
#
module Carrierwave
  module StoreAttributes
    module AdditionalImage
      extend ActiveSupport::Concern

      included do
        field :additional_image_content_type,
              type: String

        field :additional_image_extension,
              type: String

        field :additional_image_file_size,
              type: Integer

        field :additional_image_file_name,
              type: String

        process_in_background :additional_image
        field :additional_image_processing,
              type: Boolean,
              default: false
      end

      def self.included(base)
        base.before_save :_update_additional_image_attributes
      end

      private

      def _update_additional_image_attributes
        if self.class.method_defined?(:additional_image)
          if additional_image.present? && additional_image_changed?
            self.additinal_image_file_name = file.file.filename
            self.additinal_image_extension = file.file.extension.downcase
            self.additinal_image_content_type = file.file.content_type
            self.additinal_image_file_size = file.file.size
          end
        end
      end
    end
  end
end
