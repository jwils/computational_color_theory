class Image < ActiveRecord::Base
  include 'conversion_functions'
  attr_accessible :image_name
  has_many :questions
  acts_as_taggable

  def image_url
    ActionController::Base.new.view_context.asset_path(image_name)
  end

  def self.find_or_create_by_cielch(cielch, hsh = {})
    rgb = cielch_to_rgb(cielch)

  end
end
