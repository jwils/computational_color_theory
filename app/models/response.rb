class Response < ActiveRecord::Base
  belongs_to :Quiz
  belongs_to :Question
  attr_accessible :chosen_image
end
