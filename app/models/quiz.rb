class Quiz < ActiveRecord::Base
  attr_accessible :end_time, :ip_address, :ruler_height, :ruler_width, :start_time, :validation_hash, :worker_id
end
