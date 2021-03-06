module Carrierwave::StoreAttributes::AdditionalImage
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
        self.additional_image_file_name = additional_image.file.filename
        self.additional_image_extension = additional_image.file.extension.downcase
        self.additional_image_content_type = additional_image.file.content_type
        self.additional_image_file_size = additional_image.file.size
      end
    end
  end
end
