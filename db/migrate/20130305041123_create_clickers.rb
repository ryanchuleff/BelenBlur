class CreateClickers < ActiveRecord::Migration
  def change
    create_table :clickers do |t|
      t.string :address
      t.integer :clicks

      t.timestamps
    end
  end
end
