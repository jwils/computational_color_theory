class Response < ActiveRecord::Base
  belongs_to :quiz
  belongs_to :question
  attr_accessible :chosen_image
end
