class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :city
      t.string :company
      t.string :email, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :phone, null: false
      t.string :state, null: false
      t.text :notes
    end

    add_index :contacts, :email, unique: true
  end
end
