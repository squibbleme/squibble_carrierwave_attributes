module Carrierwave::StoreAttributes::Image
  extend ActiveSupport::Concern

  included do
    field :image_content_type,
          type: String

    field :image_extension,
          type: String

    field :image_file_size,
          type: Integer

    field :image_file_name,
          type: String

    process_in_background :image
    field :image_processing,
          type: Boolean,
          default: false
  end

  def self.included(base)
    base.before_save :_update_image_attributes
  end

  private

  def _update_image_attributes
    if self.class.method_defined?(:image)
      if image.present? && image_changed?
        self.image_file_name = image.file.filename
        self.image_extension = image.file.extension.downcase
        self.image_content_type = image.file.content_type
        self.image_file_size = image.file.size
      end
    end
  end
end
