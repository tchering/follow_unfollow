class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.string :country
      t.string :city
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    unless index_exists?(:addresses, :user_id)
      add_index :addresses, :user_id
    end
  end
end
