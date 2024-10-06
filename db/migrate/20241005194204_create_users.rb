class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :role

      t.timestamps
    end
    add_index :users, :username, unique: true
    add_index :users, :email, unique: true
    add_index :users, :name
    #Ex:- add_index("admin_users", "username")
  end
end
