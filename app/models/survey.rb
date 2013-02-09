class Survey < ActiveRecord::Base
  belongs_to :turkee_task, :class_name => Turkee::TurkeeTask
  has_many :questions, :through => :experiments
  has_many :responses
  belongs_to :experiment

  attr_accessible :end_time, :ip_address, :ruler_height,
                  :ruler_width, :worker_id, :comments, :responses
end
