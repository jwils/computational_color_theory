class Image < ActiveRecord::Base
  attr_accessible :image_name
  has_many :questions
end
