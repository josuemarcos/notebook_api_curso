class Contact < ApplicationRecord
belongs_to :kind
has_many :phones
accepts_nested_attributes_for :phones, allow_destroy: true
has_one :address
accepts_nested_attributes_for :address, update_only: true



validates :name, presence: true
validates :email, presence: true



def author
  "Josué"
end

def kind_description
  self.kind.description
end

def as_json(options = {})
  hash = super(options)
  hash.delete("birthdate")
  hash[:birthdate] = (I18n.l(self.birthdate) unless self.birthdate.blank?)
  hash
end
end
