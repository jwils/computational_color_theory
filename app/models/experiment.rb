class Experiment < ActiveRecord::Base
  has_many :questions
  has_many :images, :through => :questions, :source => :img1
  accepts_nested_attributes_for :images
  has_many :turkee_tasks, :class_name => 'Turkee::TurkeeTask'
  has_many :responses
  has_many :surveys

  attr_accessible :name

  acts_as_taggable


  def randomize_questions
    questions = self.questions.order("RANDOM()").compact
    questions_2 = self.questions.order("RANDOM()")
    questions_2.reject do |question|
      if questions.include?(question.matching_question)
        questions.delete(question)
      end
    end
  end

  def self.new_exp_from_tag(exp)
      e = Experiment.new
      e.save
      e.questions = Question.find_group_by_tags(exp)
      e.save
  end
end
