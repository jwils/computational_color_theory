#require 'conversion_functions'
class Image < ActiveRecord::Base
  acts_as_taggable

  attr_accessible :image_name, :tag_list, :font_size

  belongs_to :fg_color, :class_name => Color, :foreign_key => :fg_color_id
  belongs_to :bg_color, :class_name => Color, :foreign_key => :bg_color_id
  accepts_nested_attributes_for :fg_color
  accepts_nested_attributes_for :bg_color

  mount_uploader :image_name, ImageUploader

  has_many :img1_questions, :foreign_key => :img1_id, :class_name => Question
  has_many :img2_questions, :foreign_key => :img2_id, :class_name => Question

  has_many :results

  def questions
    Question.joins(:img1).joins(:img2).where('img1_id = ? or img2_id = ?', self.id, self.id).uniq
  end

  def self.questions
    joined_query = Question.joins(:img1).joins(:img2)
    joined_query.where('img1_id in (?) or img2_id in (?)', self.select(:id), self.select(:id)).uniq
  end

  def self.to_hex(rgb)
    return "##{rgb[0].to_s(16)}#{rgb[1].to_s(16)}#{rgb[2].to_s(16)}"
  end

  def image_name_tag
    "<img src=\"#{self.image_name_url}\">".html_safe + "Image ID=#{id}" + " " + tag_list
  end

  def to_arff
    "#{id}, #{results.average(:psi)*1000}, #{trip_diff_wrapper(:rgb).join(', ')}, #{trip_diff_wrapper(:rgb, :square).join(', ')}, #{trip_diff_wrapper(:rgb, :abs).join(', ')}" if results.average(:psi)
  end


  def trip_diff_wrapper(color_name, fun = nil)
    trip_diff(fg_color.to_weka(color_name),bg_color.to_weka(color_name), fun)
  end

  def to_rgb
    rgb_to_hsl
  end

  def trip_diff(trip1, trip2, fun = nil)
    response = []
    response[0] = trip1[0] - trip2[0]
    response[1] = trip1[1] - trip2[1]
    response[2] = trip1[2] - trip2[2]
    response = response.map {|x| self.send(fun, x)} if fun
    response
  end

  def square(x)
    x**2/1000
  end

  def abs(x)
    x.abs
  end

  def get_reg_val
    fg = fg_color.to_weka(:rgb)
    bg = bg_color.to_weka(:rgb)
    norm = trip_diff(fg,bg)
    square = trip_diff(fg,bg,:square)
    abs = trip_diff(fg,bg,:abs)

    (-0.1097 * norm[2] - 11.0903 * square[1] - 1.4958 * square[2] + 1.0089 * abs[0] + 5.7269 * abs[1] + 0.859 * abs[2] - 35.8276)/1000
  end

  def get_pres_val
    fg = fg_color.to_weka(:rgb)
    bg = bg_color.to_weka(:rgb)
    norm = trip_diff(fg,bg)
    square = trip_diff(fg,bg,:square)
    abs = trip_diff(fg,bg,:abs)

    (-1.1*10**-2 * norm[2] - 1.1*10**-3 * square[1] - 1.5*10**-4 * square[2] + 1*10**-1 * abs[0] + 5.7*10**-1 * abs[1] + 8.6*10**-2 * abs[2] - 3.6)/100
  end

  def get_w3c
    fg = fg_color.to_weka(:rgb)
    bg = bg_color.to_weka(:rgb)

    hue_diff  = (fg[0] - bg[0]).abs + (fg[1] - bg[1]).abs + (fg[2] - bg[2]).abs

    brightness_diff = ((299*fg[0] + 587*fg[1] + 144*fg[2]) / 1000 - (299*bg[0] + 587*bg[1] + 144*bg[2]) / 1000).abs
    if hue_diff > 500 and brightness_diff > 125
      "readable"
    else
      "not readable"
    end
  end
end
