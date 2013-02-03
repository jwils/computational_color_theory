class Survey < ActiveRecord::Base
  attr_accessible :end_time, :ip_address, :ruler_height, :ruler_width, :start_time, :validation_hash, :worker_id
  has_and_belongs_to_many :questions
  has_many :responses
end
