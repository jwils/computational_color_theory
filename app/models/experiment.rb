class Experiment < ActiveRecord::Base
  has_and_belongs_to_many :questions
  has_many :images, :through => :questions, :uniq => true, :source => :img2
  accepts_nested_attributes_for :images
  has_many :turkee_tasks, :class_name => 'Turkee::TurkeeTask'
  has_many :responses
  has_many :surveys

  attr_accessible :name, :tag_list

  acts_as_taggable


  def randomize_questions
    self.questions.order("RAND()")
  end
end
