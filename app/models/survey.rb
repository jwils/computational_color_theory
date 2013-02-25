class Survey < ActiveRecord::Base
  belongs_to :turkee_task, :class_name => Turkee::TurkeeTask
  has_many :responses
  belongs_to :experiment

  attr_accessible :end_time, :ip_address, :ruler_height,
                  :ruler_width, :worker_id, :comments, :responses,
                  :experiment_id, :responses_raw, :turkee_task_id

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

  def responses_raww

  end
end
