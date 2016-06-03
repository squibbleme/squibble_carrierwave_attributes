module Carrierwave::StoreAttributes::TeaserImage
  extend ActiveSupport::Concern

  included do
    field :teaser_image_content_type,
          type: String

    field :teaser_image_extension,
          type: String

    field :teaser_image_file_size,
          type: Integer

    field :teaser_image_file_name,
          type: String

    process_in_background :teaser_image
    field :teaser_image_processing,
          type: Boolean,
          default: false
  end

  def self.included(base)
    base.before_save :_update_teaser_image_attributes
  end

  private

  def _update_teaser_image_attributes
    if self.class.method_defined?(:teaser_image)
      if teaser_image.present? && teaser_image_changed?
        self.teaser_image_file_name = teaser_image_changed.file.filename
        self.teaser_image_extension = teaser_image_changed.file.extension.downcase
        self.teaser_image_content_type = teaser_image_changed.file.content_type
        self.teaser_image_file_size = teaser_image_changed.file.size
      end
    end
  end
end
