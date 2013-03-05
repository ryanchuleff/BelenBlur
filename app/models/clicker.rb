class Clicker < ActiveRecord::Base
  attr_accessible :address, :clicks

  def self.get_image(asset)
  	clicks = asset.assetable_id || 0

		image_id = 10-clicks

  	image_tag = 'blur' + (image_id < 0 ? 0 : image_id).to_s

  	image_tag.to_sym
  end
end
