class Photo < ActiveRecord::Base
  attr_accessible :address, :clicks

  # set up support for image
  has_one :image, :as => :assetable, :class_name => "Photo::Image", :dependent => :destroy
  accepts_nested_attributes_for :image 
end
