class Color < ActiveRecord::Base
  #include ConversionFunctions
  attr_accessible :color_type, :val1, :val2, :val3
  has_many :images

  def to_s
    "#{color_type}: (#{val1}, #{val2}, #{val3})"
  end

  def self.color_from_string(string)
    ct = string[0..2]
    vals = string[3..-1].split('-')
    self.find_or_create_by_color_type_and_val1_and_val2_and_val3(ct, *vals)
  end
end