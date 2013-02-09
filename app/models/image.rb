require 'conversion_functions'
class Image < ActiveRecord::Base
  include ConversionFunctions
  attr_accessible :image_name
  has_many :questions
  acts_as_taggable

  def image_url
    ActionController::Base.new.view_context.asset_path(image_name)
  end

  def self.find_or_create_by_cielch(cielch_fg,cielch_bg, hsh = {})
    rgb_fg = cielch_to_rgb(cielch_fg)
    rgb_bg = cielch_to_rgb(cielch_bg)
    title_image = MagickTitle.say(DEFAULT_IMG_TEXT,
                    :background_color =>to_hex(rgb_bg),
                    :color =>to_hex(rgb_fg))
  end

  def self.to_hex(rgb)
    return "##{rgb[0].to_s(16)}#{rgb[1].to_s(16)}#{rgb[2].to_s(16)}"
  end
end
