class Survey < ActiveRecord::Base
  has_many :responses
  belongs_to :experiment

  attr_accessible :end_time, :ip_address, :ruler_height, 
		  :turkee_task_id, :ruler_width, :comments, :responses,
                  :experiment_id

  def turkee_task
    Turkee::TurkeeTask.find(turkee_task_id)
  end
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
