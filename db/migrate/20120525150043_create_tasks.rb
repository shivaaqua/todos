class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string    :title,      :null => false, :limit => 100
      t.string    :status,     :null => false, :limit => 10
      t.boolean   :active,     :null => false, :default => true
      t.datetime  :deleted_at
      t.timestamps
    end
    add_index :tasks, :title
    add_index :tasks, :created_at
    add_index :tasks, :status
  end
end
