module Carrierwave::StoreAttributes::UnsignedContract
  extend ActiveSupport::Concern

  included do
    field :unsigned_contract_content_type,
          type: String

    field :unsigned_contract_extension,
          type: String

    field :unsigned_contract_file_size,
          type: Integer

    field :unsigned_contract_file_name,
          type: String
  end

  def self.included(base)
    base.before_save :_update_unsigned_contract_attributes
  end

  private

  def _update_unsigned_contract_attributes
    if self.class.method_defined?(:unsigned_contract)
      if unsigned_contract.present? && unsigned_contract_changed?
        self.unsigned_contract_file_name = unsigned_contract.file.filename
        self.unsigned_contract_extension = unsigned_contract.file.extension.downcase
        self.unsigned_contract_content_type = unsigned_contract.file.content_type
        self.unsigned_contract_file_size = unsigned_contract.file.size
      end
    end
  end
end
