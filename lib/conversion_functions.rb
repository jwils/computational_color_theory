module ConversionFunctions
  def xyz_to_rgb(xyz)
    #  convert xyz array or list to RGB array
    var_x = xyz[0]/100.0
    var_y = xyz[1]/100.0
    var_z = xyz[2]/100.0

    var_R = var_x *  3.2406 + var_y * -1.5372 + var_z * -0.4986
    var_G = var_x * -0.9689 + var_y *  1.8758 + var_z *  0.0415
    var_B = var_x *  0.0557 + var_y * -0.2040 + var_z *  1.0570

    if var_R > 0.0031308
      var_R = 1.055 * (var_R** (1/2.4)) - 0.055
    else
      var_R = 12.92 * var_R
    end
    if var_G > 0.0031308
      var_G = 1.055 * (var_G**(1/2.4)) - 0.055
    else
      var_G = 12.92 * var_G
    end
    if var_B > 0.0031308
        var_B = 1.055 * (var_B**(1/2.4)) - 0.055
    else
      var_B = 12.92 * var_B
    end

    return (var_R*255).round,(var_G*255).round,(var_B*255).round
  end

  def cielab_to_xyz(cielab)
    # convert CIE-L*ab array or list to xyz array
    var_y = (cielab[0] + 16.0) / 116.0
    var_x = (cielab[1] / 500.0) + var_y
    var_z = var_y - (cielab[2] / 200.0)

    epsilon = 0.008856

    if var_y*var_y*var_y > epsilon
      var_y = var_y*var_y*var_y
    else
      var_y = (var_y - (16.0/116.0)) / 7.787
    end
    if var_x*var_x*var_x > epsilon
      var_x =  var_x*var_x*var_x
    else
      var_x = ( var_x - 16 / 116 ) / 7.787
    end
    if var_z*var_z*var_z > epsilon
      var_z =  var_z*var_z*var_z
    else
      var_z = ( var_z - 16 / 116 ) / 7.787
    end

    return 95.0429 * var_x,100.0 * var_y,108.8900 * var_z
  end

  def cielch_to_cielab(cielch)
    # convert CIE-L*CH^o array to CIE-L*ab array
    ciel = cielch[0]
    ciea = Math.cos(cielch[2]/180.0*Math::PI) * cielch[1]
    cieb = Math.sin(cielch[2]/180.0*Math::PI) * cielch[1]
    return [ciel,ciea,cieb]
  end

  def cielch_to_rgb(cielch)
    # convert CIE-L*CH^o array to xyz array
    return xyz_to_rgb(cielab_to_xyz(cielch_to_cielab(cielch)))
  end

  def rgb_to_hsl(rgb)
    r = rgb[0]
    g = rgb[1]
    b = rgb[2]
    var_R = ( r / 255.0 )                     #RGB from 0 to 255
    var_G = ( g / 255.0 )
    var_B = ( b / 255.0 )

    var_Min = Math.min( var_R, var_G, var_B )    #Min. value of RGB
    var_Max = Math.max( var_R, var_G, var_B )    #Max. value of RGB
    del_Max = var_Max - var_Min             #Delta RGB value
    l = ( var_Max + var_Min ) / 2.0

    h = 0.0
    s = 0.0
    if del_Max
      if l < 0.5
        s = del_Max / ( var_Max + var_Min )
      else
        s = del_Max / ( 2 - var_Max - var_Min )
      end
      if var_R == var_Max
        h = ((var_G - var_B)/del_Max) % 6
      elsif var_G == var_Max
        h = ((var_B - var_R)/del_Max)+2
      elsif var_B == var_Max
        h = ((var_R - var_G)/del_Max)+4
      end
    end
    return (h*60).round,(s*100).round,(l*100).round
  end

  def rgb_to_xyz(rgb)
    r = rgb[0]
    g = rgb[1]
    b = rgb[2]

    var_R = ( r / 255.0 )
    var_G = ( g / 255.0 )
    var_B = ( b / 255.0 )

    if ( var_R > 0.04045 )
        var_R = ( ( var_R + 0.055 ) / 1.055 )**2.4
    else
      var_R = var_R / 12.92
    end
    if ( var_G > 0.04045 )
      var_G = ( ( var_G + 0.055 ) / 1.055 )**2.4
    else
      var_G = var_G / 12.92
    end
    if ( var_B > 0.04045 )
      var_B = ( ( var_B + 0.055 ) / 1.055 )**2.4
    else
      var_B = var_B / 12.92
    end
    var_R = var_R * 100
    var_G = var_G * 100
    var_B = var_B * 100

    x = var_R * 0.4124 + var_G * 0.3576 + var_B * 0.1805
    y = var_R * 0.2126 + var_G * 0.7152 + var_B * 0.0722
    z = var_R * 0.0193 + var_G * 0.1192 + var_B * 0.9505

    return 100*x,100*y,100*z
  end

  def xyz_to_cielab(xyz)
  x = xyz[0]
  y = xyz[1]
  z = xyz[2]

  var_x = x / 95.047
  var_y = y / 100.0
  var_z = z / 108.883

  if var_x > 0.008856
    var_x = var_x**( 1/3.0 )
  else
    var_x = ( 7.787 * var_x ) + ( 16 / 116 )
  end
  if var_y > 0.008856
    var_y = var_y**( 1/3.0 )
  else
    var_y = ( 7.787 * var_y ) + ( 16 / 116 )
  end
  if var_z > 0.008856
    var_z = var_z**( 1/3.0 )
  else
    var_z = ( 7.787 * var_z ) + ( 16 / 116 )
  end
  ciel = ( 116 * var_y ) - 16
  ciea = 500 * ( var_x - var_y )
  cieb = 200 * ( var_y - var_z )
  return ciel, ciea, cieb
  end

  def cielab_to_cielch(cielab)
    ciel = cielab[0]
    ciea = cielab[1]
    cieb = cielab[2]
    var_H = Math.atan2( cieb, ciea )

    if ( var_H > 0 )
        var_H = ( var_H / Math.pi ) * 180
    else
      var_H = 360 - (  var_H.abs / Math.pi ) * 180
    end
      ciel = ciel
      ciec = Math.sqrt(ciea**2 + cieb**2 )
      cieh = var_H

    return ciel, ciec, cieh
  end

  def rgb_to_cielab(rgb)
    xyz_to_cielab(rgb_to_xyz(rgb))
  end

  def rgb_to_cielch(rgb)
    cielab_to_cielch(rgb_to_cielab(rgb))
  end

  def hsl_to_rgb(hsl)
    h = hsl[0].to_f
    s = hsl[1]/100.0
    l = hsl[2]/100.0

    c = (1-(2*l - 1).abs)*s
    x = c*(1-((h/60)%2-1).abs)
    m = l-(c/2)
    r = 0
    b = 0
    g = 0

    if h < 60
      r = c
      g = x
      b = 0
    elsif h < 120
      r = x
      g = c
      b = 0
    elsif h < 180
      r = 0
      g = c
      b = x
    elsif h < 240
      r = 0
      g = x
      b = c
    elsif h < 300
      r = x
      g = 0
      b = c
    else
      r = c
      g = 0
      b = x
    end

    return 255*(r+m), 255*(g+m), int(255*(b+m))
  end
end