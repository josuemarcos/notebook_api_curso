class Contact < ApplicationRecord
  belongs_to :kind
  has_many :phones
  accepts_nested_attributes_for :phones, allow_destroy: true
  has_one :address
  accepts_nested_attributes_for :adress, update_only: true
  
end
