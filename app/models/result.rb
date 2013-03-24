class Result < ActiveRecord::Base
  belongs_to :experiment
  belongs_to :image
  attr_accessible :psi, :noise
  acts_as_taggable

end
