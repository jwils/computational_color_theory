class Question < ActiveRecord::Base
  belongs_to :img1
  belongs_to :img2
  # attr_accessible :title, :body
end
