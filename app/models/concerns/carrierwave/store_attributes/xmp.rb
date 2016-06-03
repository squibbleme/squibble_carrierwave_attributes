module Carrierwave::StoreAttributes::Xmp
  extend ActiveSupport::Concern

  included do
    field :xmp_file_content_type,
          type: String

    field :xmp_file_extension,
          type: String

    field :xmp_file_file_size,
          type: Integer

    field :xmp_file_file_name,
          type: String

    # field :xmp_file_processing,
    #       type: Boolean,
    #       default: false
  end

  def self.included(base)
    base.before_save :_update_xmp_attributes
  end

  private

  def _update_xmp_attributes
    if self.class.method_defined?(:xmp)
      if xmp.present? && xmp_changed?
        self.xmp_file_name = xmp.file.filename
        self.xmp_extension = xmp.file.extension.downcase
        self.xmp_content_type = xmp.file.content_type
        self.xmp_file_size = xmp.file.size
      end
    end
  end
end
