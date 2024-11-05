class ContactSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :birthdate

  belongs_to :kind
  has_many :phones
  has_one :address

  link(:self) {contact_url(object.id)}
  link(:kind) {kind_url(object.kind.id)}


  meta do
    {author: "Josué Fernandes"}
  end
end
