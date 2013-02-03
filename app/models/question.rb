class Question < ActiveRecord::Base
  belongs_to :img1, :class_name => Image, :foreign_key => :img1_id
  belongs_to :img2, :class_name => Image, :foreign_key => :img2_id
  has_and_belongs_to_many :quizzes
  has_many :answers
end
