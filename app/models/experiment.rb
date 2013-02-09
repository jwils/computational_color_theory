class Experiment < ActiveRecord::Base
  belongs_to :question
  belongs_to :turkee_tasks, :class_name => 'Turkee::TurkeeTask'
  has_many :questions
  acts_as_taggable

end
