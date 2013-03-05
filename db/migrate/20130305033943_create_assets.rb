class CreateAssets < ActiveRecord::Migration
  def self.up
    create_table :assets do |t|
      t.string :type
      t.string :label
      t.text :description
      t.integer :assetable_id
      t.string :assetable_type
      t.attachment :asset
      t.timestamps
    end
  end

  def self.down
    drop_table :assets
  end
end
