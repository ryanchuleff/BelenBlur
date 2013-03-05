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

class Asset < ActiveRecord::Base

	attr_accessible :asset

	has_attached_file :asset, :bucket => "planttogether_public_beta", 
										:styles => {:blur10 => "400x400#", :blur9 => "400x400#", :blur8 => "400x400#", :blur7 => "400x400#", :blur6 => "400x400#",
																:blur5 => "400x400#", :blur4 => "400x400#", :blur3 => "400x400#", :blur2 => "400x400#", :blur1 => "400x400#",
																:blur0 => "400x400#"},
										:convert_options => {:blur10 => "-blur 0x100", :blur9 => "-blur 0x85", :blur8 => "-blur 0x72", :blur7 => "-blur 0x60", 
																				:blur6 => "-blur 0x50", :blur5 => "-blur 0x40", :blur4 => "-blur 0x30", :blur3 => "-blur 0x20", 
																				:blur2 => "-blur 0x10", :blur1 => "-blur 0x5"}
 

  def name
  	asset_file_name
  end

  def content_type
  	asset_content_type
  end

  def browser_safe?
    %w(jpg gif png).include?(url.split('.').last.sub(/\?.+/, "").downcase)
  end
  alias_method :web_safe?, :browser_safe?

  # necessary for doing STI 
  def attachable_type=(sType)
    super(sType.to_s.classify.constantize.base_class.to_s)
  end  

  # This method assumes you have images that corespond to the filetypes.
  # For example "image/png" becomes "image-png.png"
  def icon
    "file_icons/32px/#{asset_content_type.split('.').last.sub(/\?.+/, "").downcase}.png"
  end


=begin ImageMagick Filters

  source: http://www.fmwconcepts.com/imagemagick/flicker/index.php
  ref: fmw@alink.net

  #filtering
  accent edges  params: -w 1 -s 40 -p black -b 0.5 -c over 
  command: 
      convert $infile \ \( -clone 0 -fill $polarity -colorize 100 \) \
      \( -clone 0 -set colorspace RGB -colorspace gray \
      -morphology edgeout diamond:$width -blur 0x$blur -evaluate multiply $strength \) \
      -compose $cmethod -composite $outfile

convert home.jpg \ \( -clone 0 -fill black -colorize 100 \) \
\( -clone 0 -set colorspace RGB -colorspace gray \
-morphology edgeout diamond:1 -blur 0x0.5 -evaluate multiply 40 \) \
-compose over -composite home_accent.jpg

  tintilize   params: -m "hsl(150,25%,50%)"
  command:

    offset=`convert xc: -format "%[fx:$offset*128/100]" info:`
    convert -size 1x1 xc:black xc:$mcolor xc:white +append \
    -filter $type -resize 256x1! \
    -contrast-stretch 0 \
    -virtual-pixel edge -fx "u.p{(i-(w/2))*(100+$contrast)/(100)+(w/2)-$offset,j}" \
    $tmp0
    convert $infile $tmp0 -clut $outfile

    polaroid
    command:
      convert -caption '%c %f\n%wx%h' spiral_stairs_sm.jpg -thumbnail 120x120 \
          -bordercolor Lavender  -background gray40  +polaroid \
          poloroid_captioned.png

      convert spiral_stairs_sm.jpg -thumbnail 120x120 \
          -bordercolor AliceBlue -background SteelBlue4 -polaroid 5 \
          poloroid_5.png

    pencil sketch (grayscale)
    command:
      convert pagoda_sm.jpg -colorspace gray \
          \( +clone -tile pencil_tile.gif -draw "color 0,0 reset" \
             +clone +swap -compose color_dodge -composite \) \
          -fx 'u*.2+v*.8' sketch.gif

    basic edging
    command:
      convert piglet_edge_neg.gif  -blur 0x.5  piglet_edge_blur.gif


   shadowing w/merge to parent.


convert [icon_url] -resize [width]x[height] -flip +distort SRT '0,0 1,-1 0' \( +clone -background black -shadow 60x5+0+0 -virtual-pixel transparent +distort affine '0,0 -20,0 -60,0 -70,0 0,150 -70,130' \) +swap -background none -layers merge -fuzz 2% -repage +[left]+[top] \( [design_url] +repage \) -compose DstOver -background none -layers merge +repage [result_url]


=end
end
