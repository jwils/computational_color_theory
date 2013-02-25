class Response < ActiveRecord::Base
  belongs_to :survey
  belongs_to :question
  attr_accessible :chosen_image, :reversed, :survey_id, :question_id
  acts_as_taggable

  def experiment
    self.survey.experiment unless self.survey.nil?
  end
end
