#require 'conversion_functions'
class Image < ActiveRecord::Base
  attr_accessible :image_name, :tag_list
  belongs_to :fg_color, :class_name => Color, :foreign_key => :fg_color_id
  belongs_to :bg_color, :class_name => Color, :foreign_key => :bg_color_id
  accepts_nested_attributes_for :fg_color
  accepts_nested_attributes_for :bg_color

  mount_uploader :image_name, ImageUploader

  has_many :questions
  acts_as_taggable

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

  def image_name_tag
    "<img src=\"#{self.image_name_url}\">".html_safe + "Image ID=#{id}" + " " + tag_list
  end
end
