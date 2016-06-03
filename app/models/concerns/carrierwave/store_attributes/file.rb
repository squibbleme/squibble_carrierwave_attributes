module Carrierwave::StoreAttributes::File
  extend ActiveSupport::Concern

  included do
    field :file_content_type,
          type: String

    field :file_extension,
          type: String

    field :file_file_size,
          type: Integer

    field :file_file_name,
          type: String

    process_in_background :file
    field :file_processing,
          type: Boolean,
          default: false
  end

  def self.included(base)
    base.before_save :_update_file_attributes
  end

  private

  def _update_file_attributes
    if self.class.method_defined?(:file)
      if file.present? && file_changed?
        self.file_file_name = file.file.filename
        self.file_extension = file.file.extension.downcase
        self.file_content_type = file.file.content_type
        self.file_file_size = file.file.size
      end
    end
  end
end
