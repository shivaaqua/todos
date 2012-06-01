class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
     t.string :email,           :null => false, :limit => 150
      t.string :password_digest, :null => false 
      t.string :mobile,          :null => false, :limit => 15 
      t.timestamps
    end
  end
end
