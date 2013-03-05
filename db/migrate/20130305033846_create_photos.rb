class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :address
      t.integer :clicks

      t.timestamps
    end
  end
end
