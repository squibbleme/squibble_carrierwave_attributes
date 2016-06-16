module Carrierwave::StoreAttributes::HeaderImage
  extend ActiveSupport::Concern

  included do
    field :header_image_content_type,
          type: String

    field :header_image_extension,
          type: String

    field :header_image_file_size,
          type: Integer

    field :header_image_file_name,
          type: String

    process_in_background :header_image
    field :header_image_processing,
          type: Boolean,
          default: false
  end

  def self.included(base)
    base.before_save :_update_header_image_attributes
  end

  private

  def _update_header_image_attributes
    if self.class.method_defined?(:header_image)
      if header_image.present? && header_image_changed?
        self.header_image_file_name = header_image.file.filename
        self.header_image_extension = header_image.file.extension.downcase
        self.header_image_content_type = header_image.file.content_type
        self.header_image_file_size = header_image.file.size
      end
    end
  end
end
