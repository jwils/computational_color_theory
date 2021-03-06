class Color < ActiveRecord::Base
  include ConversionFunctions
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

  def to_weka(format = :rgb)
    vals = [val1, val2, val3]
    if color_type == 'hsl'
      vals = hsl_to_rgb(vals)
    end
    method = 'rgb_to_' + format.to_s
    raise "ERORR" unless (self.respond_to? method or format.to_s == 'rgb')
    vals = self.send(method, vals) unless format.to_s == 'rgb'
    vals[0] = 0 if vals[0] < 0
    vals[1] = 0 if vals[1] < 0
    vals[2] = 0 if vals[2] < 0
    return vals
  end

  def get_all_color_data
    (to_weka(:rgb) + to_weka(:xyz) + to_weka(:hsl) + to_weka(:cielab) + to_weka(:cielch)).join(', ')
  end

end
