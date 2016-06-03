module Carrierwave::StoreAttributes::Ics
  extend ActiveSupport::Concern

  included do
    field :ics_content_type,
          type: String

    field :ics_file_size,
          type: Integer

    field :ics_file_name,
          type: String

    field :ics_extension,
          type: String
  end

  def self.included(base)
    base.before_save :_update_ics_attributes
  end

  private

  def _update_ics_attributes
    if self.class.method_defined?(:ics)
      if ics.present? && ics_changed?
        self.ics_file_name = file.file.filename
        self.ics_content_type = ics.file.content_type
        self.ics_file_size = ics.file.size
        self.ics_extension = ics.file.extension.downcase
      end
    end
  end
end
