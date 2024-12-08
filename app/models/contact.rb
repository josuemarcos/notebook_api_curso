class Contact < ApplicationRecord
 # include Elasticsearch::Model
 # include Elasticsearch::Model::Callbacks
  searchkick
  belongs_to :kind
  belongs_to :login
  has_many :phones, dependent: :destroy
  accepts_nested_attributes_for :phones, allow_destroy: true
  has_one :address, dependent: :destroy
  accepts_nested_attributes_for :address, update_only: true
  
end
