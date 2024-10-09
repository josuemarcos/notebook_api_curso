class ContactSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :birthdate

  def attributes(*args)
  hash = super(*args)
  hash[:birthdate] = (I18n.l(object.birthdate) unless object.birthdate.blank?)
  hash
  end
end
