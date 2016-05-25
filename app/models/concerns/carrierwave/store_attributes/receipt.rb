# Dieses Modul kümmert sich darum, dass, sofern das Attribut
# hash_tags vorhanden ist, dieses entsprechend formatiert wird.
#
module Carrierwave
  module StoreAttributes
    module Receipt
      extend ActiveSupport::Concern

      included do
        field :receipt_content_type,
              type: String

        field :receipt_extension,
              type: String

        field :receipt_file_size,
              type: Integer

        field :receipt_file_name,
              type: String
      end

      def self.included(base)
        base.before_save :_update_receipt_attributes
      end

      private

      def _update_receipt_attributes
        if self.class.method_defined?(:receipt)
          if receipt.present? && receipt_changed?
            self.receipt_file_name = receipt.file.filename
            self.receipt_extension = receipt.file.extension.downcase
            self.receipt_content_type = receipt.file.content_type
            self.receipt_file_size = receipt.file.size
          end
        end
      end
    end
  end
end
