class AddKindToContact < ActiveRecord::Migration[7.2]
  def change
    add_reference :contacts, :kind, foreign_key: true
  end
end
