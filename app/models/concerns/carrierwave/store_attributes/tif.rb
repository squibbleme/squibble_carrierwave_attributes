# Dieses Modul kümmert sich darum, dass, sofern das Attribut
# :tif vorhanden ist, dieses entsprechend formatiert wird.
#
module Carrierwave
  module StoreAttributes
    module Tif
      extend ActiveSupport::Concern

      included do
        field :til_file_content_type,
              type: String

        field :til_file_extension,
              type: String

        field :til_file_file_size,
              type: Integer

        field :til_file_file_name,
              type: String

        # field :til_file_processing,
        #       type: Boolean,
        #       default: false
      end

      def self.included(base)
        base.before_save :_update_tif_attributes
      end

      private

      def _update_tif_attributes
        if self.class.method_defined?(:tif)
          if tif.present? && tif_changed?
            self.tif_file_name = tif.file.filename
            self.tif_extension = tif.file.extension.downcase
            self.tif_content_type = tif.file.content_type
            self.tif_file_size = tif.file.size
          end
        end
      end
    end
  end
end
