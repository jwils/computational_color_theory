class Response < ActiveRecord::Base
  belongs_to :survey
  belongs_to :question
  attr_accessible :chosen_image
end
