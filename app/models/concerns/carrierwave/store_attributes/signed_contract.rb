module Carrierwave::StoreAttributes::SignedContract
  extend ActiveSupport::Concern

  included do
    field :signed_contract_content_type,
          type: String

    field :signed_contract_extension,
          type: String

    field :signed_contract_file_size,
          type: Integer

    field :signed_contract_file_name,
          type: String
  end

  def self.included(base)
    base.before_save :_update_signed_contract_attributes
  end

  private

  def _update_signed_contract_attributes
    if self.class.method_defined?(:signed_contract)
      if signed_contract.present? && signed_contract_changed?
        self.signed_contract_file_name = signed_contract.file.filename
        self.signed_contract_extension = signed_contract.file.extension.downcase
        self.signed_contract_content_type = signed_contract.file.content_type
        self.signed_contract_file_size = signed_contract.file.size
      end
    end
  end
end
