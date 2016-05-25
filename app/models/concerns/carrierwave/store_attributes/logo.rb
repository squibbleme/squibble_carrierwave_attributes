# Dieses Modul kümmert sich darum, dass, sofern das Attribut
# hash_tags vorhanden ist, dieses entsprechend formatiert wird.
#
module Carrierwave
  module StoreAttributes
    module Logo
      extend ActiveSupport::Concern

      included do
        field :logo_content_type,
              type: String

        field :logo_extension,
              type: String

        field :logo_file_size,
              type: Integer

        field :logo_file_name,
              type: String

        field :logo_processing,
              type: Boolean,
              default: false
      end

      def self.included(base)
        base.before_save :_update_logo_attributes
      end

      private

      def _update_logo_attributes
        if self.class.method_defined?(:logo)
          if logo.present? && logo_changed?
            self.logo_file_name = file.file.filename
            self.logo_extension = file.file.extension.downcase
            self.logo_content_type = file.file.content_type
            self.logo_file_size = file.file.size
          end
        end
      end
    end
  end
end
