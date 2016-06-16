module Carrierwave::StoreAttributes::FooterImage
  extend ActiveSupport::Concern

  included do
    field :footer_image_content_type,
          type: String

    field :footer_image_extension,
          type: String

    field :footer_image_file_size,
          type: Integer

    field :footer_image_file_name,
          type: String

    process_in_background :footer_image
    field :footer_image_processing,
          type: Boolean,
          default: false
  end

  def self.included(base)
    base.before_save :_update_footer_image_attributes
  end

  private

  def _update_footer_image_attributes
    if self.class.method_defined?(:footer_image)
      if footer_image.present? && footer_image_changed?
        self.footer_image_file_name = footer_image.file.filename
        self.footer_image_extension = footer_image.file.extension.downcase
        self.footer_image_content_type = footer_image.file.content_type
        self.footer_image_file_size = footer_image.file.size
      end
    end
  end
end
