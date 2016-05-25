# Dieses Modul kümmert sich darum, dass, sofern das Attribut
# hash_tags vorhanden ist, dieses entsprechend formatiert wird.
#
module Carrierwave
  module StoreAttributes
    module Portrait
      extend ActiveSupport::Concern

      included do
        field :portrait_content_type,
              type: String

        field :portrait_file_size,
              type: Integer

        field :portrait_file_name,
              type: String

        field :portrait_extension,
              type: String

        process_in_background :portrait
        field :portrait_processing,
              type: Boolean,
              default: false
      end

      def self.included(base)
        base.before_save :_update_portrait_attributes
      end

      private

      def _update_portrait_attributes
        if self.class.method_defined?(:portrait)
          if portrait.present? && portrait_changed?
            self.portrait_file_name = file.file.filename
            self.portrait_extension = file.file.extension.downcase
            self.portrait_content_type = file.file.content_type
            self.portrait_file_size = file.file.size
          end
        end
      end
    end
  end
end
