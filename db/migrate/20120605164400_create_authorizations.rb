class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.integer :user_id
      t.string :provider,   :null => false
      t.string :uid,        :null => false
      t.string :email
      t.timestamps
    end
    add_index :authorizations, :uid
  end
end
