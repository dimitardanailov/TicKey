class CreateCardPurches < ActiveRecord::Migration
  def change
    create_table :card_purches do |t|
      t.integer :user_id,
        :null => false

      t.integer :transport_card_type_id,
        :null => false

      t.integer :line_id,
        :null => false

      t.datetime :expire_date,
        :null => true

      t.timestamps

      t.foreign_key :users, dependent: :delete

      t.foreign_key :transport_card_types, dependent: :delete

      t.foreign_key :lines, dependent: :delete
    end
  end
end
