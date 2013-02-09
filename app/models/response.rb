class Response < ActiveRecord::Base
  belongs_to :survey
  belongs_to :question
  belongs_to :experiment
  attr_accessible :chosen_image
end
