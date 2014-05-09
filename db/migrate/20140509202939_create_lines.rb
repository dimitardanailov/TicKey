class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.string :name,
        :null => false

      t.decimal :price,
        :precision => 8,
        :scale => 2,
        :null => true

      t.timestamps
    end
  end
end
