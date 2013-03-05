# == Schema Information
#
# Table name: assets
#
#  id                 :integer          not null, primary key
#  type               :string(255)
#  label              :string(255)
#  description        :text
#  assetable_id       :integer
#  assetable_type     :string(255)
#  asset_file_name    :string(255)
#  asset_content_type :string(255)
#  asset_file_size    :integer
#  asset_updated_at   :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Photo::Image < Asset

  attr_accessible :asset

  # enable sketchification of the uploaded design
  parameters = []
	parameters << "-set colorspace RGB" << "+repage"
	parameters << "\\( -clone 0 -fill black -colorize 100 \\)"
	parameters << "\\( -clone 0 -set colorspace RGB -colorspace gray -morphology edgeout diamond:2 -blur 0x0.5 -evaluate Multiply 4 \\)"
	parameters << "-compose Over -composite"
	parameters << "-colorspace gray +repage" << "#{Rails.root}/app/assets/images/lutfile.png -clut"
	parameters = parameters.flatten.compact.join(" ").strip.squeeze(" ")

  has_attached_file :asset,
  									:styles => { :blur10 => "400x400#", :blur9 => "400x400#", :blur8 => "400x400#", :blur7 => "400x400#", :blur6 => "400x400#", 
                                 :blur5 => "400x400#", :blur4 => "400x400#", :blur3 => "400x400#", :blur2 => "400x400#", :blur1 => "400x400#", 
                                 :blur0 => "400x400#" },
  									:convert_options => {:blur10 => "-blur 0x100", :blur9 => "-blur 0x90", :blur8 => "-blur 0x75", :blur7 => "-blur 0x60", 
                                 :blur6 => "-blur 0x50", :blur5 => "-blur 0x35", :blur4 => "-blur 0x20", :blur3 => "-blur 0x15", 
                                 :blur2 => "-blur 0x10", :blur1 => "-blur 0x5" }

end
