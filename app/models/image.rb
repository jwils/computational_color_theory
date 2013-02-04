class Image < ActiveRecord::Base
  attr_accessible :image_name
  has_many :questions


  def image_url
    ActionController::Base.new.view_context.asset_path(image_name)
  end
end
