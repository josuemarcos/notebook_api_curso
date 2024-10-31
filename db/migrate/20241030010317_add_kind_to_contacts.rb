class AddKindToContacts < ActiveRecord::Migration[7.2]
  def change
    add_reference :contacts, :kind, null: false, foreign_key: true
  end
end
