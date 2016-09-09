module Carrierwave::StoreAttributes::Thumbnail
  extend ActiveSupport::Concern

  included do
    field :thumbnail_content_type,
          type: String

    field :thumbnail_extension,
          type: String

    field :thumbnail_file_size,
          type: Integer

    field :thumbnail_file_name,
          type: String

    process_in_background :thumbnail
    field :thumbnail_processing,
          type: Boolean,
          default: false
  end

  def self.included(base)
    base.before_save :_update_thumbnail_attributes
  end

  private

  def _update_thumbnail_attributes
    if self.class.method_defined?(:thumbnail)
      if thumbnail.present? && thumbnail_changed?
        self.thumbnail_file_name = thumbnail.file.filename
        self.thumbnail_extension = thumbnail.file.extension.downcase
        self.thumbnail_content_type = thumbnail.file.content_type
        self.thumbnail_file_size = thumbnail.file.size
      end
    end
  end
end
