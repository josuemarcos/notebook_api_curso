class AddLoginToContact < ActiveRecord::Migration[7.2]
  def change
    add_reference :contacts, :login, foreign_key: true
  end
end
