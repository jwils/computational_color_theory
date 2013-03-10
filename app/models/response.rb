class Response < ActiveRecord::Base
  belongs_to :survey
  belongs_to :question
  attr_accessible :chosen_image, :reversed, :survey_id, :question_id
  acts_as_taggable

  def experiment
    self.survey.experiment unless self.survey.nil?
  end

  def img1
    if reversed == 1
      question.img2
    else
      question.img1
    end
  end

  def img2
    if reversed == 1
      question.img1
    else
      question.img2
    end
  end

  def chosen_index
    if chosen_image == 'img1'
      reversed + 1
    else
      2 - reversed
    end
  end

  def self.to_csv
    CSV.generate(options) do |csv|
      csv << %w[image_1_id image_2_id chosen]
      all.each do |response|
        csv << [img1, img2, chosen_index]
      end
    end
  end
end
