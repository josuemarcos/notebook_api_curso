class ContactSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :birthdate

  belongs_to :kind

  belongs_to :login

  
  has_many :phones do
    link(:related) { contact_phones_url(object.id) }
  end

  has_one :address do
    link(:related) { contact_address_url(object.id) }
  end
  

  link(:self) { contact_url(object.id) }



  meta do
    { author: "Josué Fernandes" }
  end
end
