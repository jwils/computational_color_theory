class Experiment < ActiveRecord::Base
  has_many :questions
  belongs_to :turkee_tasks, :class_name => 'Turkee::TurkeeTask'
  has_many :responses
  has_many :surveys
  acts_as_taggable


  def randomize_questions
    questions = questions.order("RANDOM()").compact
    questions_2 = questions.order("RANDOM()")
    questions_2.reject do |question|
      if questions.include?(question.matching_question)
        questions.delete(question)
      end
    end
  end
end
