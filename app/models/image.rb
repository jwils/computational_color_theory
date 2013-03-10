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
end
