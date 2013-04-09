class Experiment < ActiveRecord::Base
  has_and_belongs_to_many :questions
  has_many :images, :through => :questions, :source => :img1, :uniq => true
  accepts_nested_attributes_for :images
  has_many :turkee_tasks, :class_name => 'Turkee::TurkeeTask'
  has_many :responses, :through => :surveys
  has_many :surveys

  attr_accessible :name, :tag_list

  acts_as_taggable


  def get_images
    self.questions.images
  end

  def randomize_questions
    self.questions.order("RANDOM()")
  end
end
