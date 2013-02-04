class Survey < ActiveRecord::Base
  belongs_to :turkee_task, :class_name => Turkee::TurkeeTask
  has_and_belongs_to_many :questions
  has_many :responses
  attr_accessible :end_time, :ip_address, :ruler_height, :ruler_width, :start_time, :validation_hash, :worker_id
end
