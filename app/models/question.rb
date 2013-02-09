class Question < ActiveRecord::Base
  belongs_to :img1, :class_name => Image, :foreign_key => :img1_id
  belongs_to :img2, :class_name => Image, :foreign_key => :img2_id
  belongs_to :experiment
  has_many :questions, :through => :experiments
  has_many :responses
  attr_accessible  :img1, :img2, :tag_list
  acts_as_taggable


  def self.get_random_questions(num_questions)
    self.order("RANDOM()").limit(num_questions)
  end
end
