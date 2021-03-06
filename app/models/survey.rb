class Survey < ActiveRecord::Base
  belongs_to :turkee_task, :class_name => Turkee::TurkeeTask
  has_many :responses
  belongs_to :experiment

  attr_accessible :ip_address, :ruler_height,
                  :ruler_width, :comments, :responses,
                  :experiment_id, :turkee_task_id, :responses_raw

  def responses_raw=(responses)
    resp = []
    self.save
    JSON(responses).each do |response|
      resp << Response.create do |r|
        r.survey_id = self.id
        r.question_id = response["question_id"]
        r.chosen_image = response["chosen_image"]
        r.reversed =  response["d"]
      end
    end
  end
end
