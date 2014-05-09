class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :user_type_id,
        :null => false,
        :default => 1

      t.string :email,
        :null => false,
        :unique => true,
        :limit => 120
      
      t.string :first_name,
        :null => false,
        :limit => 120

      t.string :last_name,
        :null => false,
        :limit => 120

      t.string :pin,
        :null => false,
        :unique => true,
        :limit => 12

      t.string :password,
        :null => false

      t.string :picture,
        :null => true

      t.timestamps
    end
  end
end
