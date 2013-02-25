class Color < ActiveRecord::Base
  #include ConversionFunctions
  attr_accessible :color_type, :val1, :val2, :val3

  #has_many :images
end