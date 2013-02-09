module CONVERSION_FUNCTIONS
  def xyz_to_rgb(xyz)
    #  convert XYZ array or list to RGB array
    var_X = xyz[0]/100.0
    var_Y = xyz[1]/100.0
    var_Z = xyz[2]/100.0

    var_R = var_X *  3.2406 + var_Y * -1.5372 + var_Z * -0.4986
    var_G = var_X * -0.9689 + var_Y *  1.8758 + var_Z *  0.0415
    var_B = var_X *  0.0557 + var_Y * -0.2040 + var_Z *  1.0570

    if var_R > 0.0031308
      var_R = 1.055 * (Math.pow(var_R, (1/2.4))) - 0.055
    else
      var_R = 12.92 * var_R
    end
    if var_G > 0.0031308
      var_G = 1.055 * (Math.pow(var_G,(1/2.4))) - 0.055
    else
      var_G = 12.92 * var_G
    end
    if var_B > 0.0031308:
        var_B = 1.055 * (Math.pow(var_B,(1/2.4))) - 0.055
    else
      var_B = 12.92 * var_B
    end

    return [(var_R*255).round,(var_G*255).round,(var_B*255).round]
  end

  def cielab_to_xyz(cielab)
    # convert CIE-L*ab array or list to XYZ array
    var_Y = (cielab[0] + 16.0) / 116.0
    var_X = (cielab[1] / 500.0) + var_Y
    var_Z = var_Y - (cielab[2] / 200.0)

    epsilon = 0.008856

    if var_Y*var_Y*var_Y > epsilon
      var_Y = var_Y*var_Y*var_Y
    else
      var_Y = (var_Y - (16.0/116.0)) / 7.787
    end
    if var_X*var_X*var_X > epsilon
      var_X =  var_X*var_X*var_X
    else
      var_X = ( var_X - 16 / 116 ) / 7.787
    end
    if var_Z*var_Z*var_Z > epsilon
      var_Z =  var_Z*var_Z*var_Z
    else
      var_Z = ( var_Z - 16 / 116 ) / 7.787
    end

    return [95.0429 * var_X,100.0 * var_Y,108.8900 * var_Z]
  end

  def cielch_to_cielab(cielch)
    # convert CIE-L*CH^o array to CIE-L*ab array
    cie_l = cielch[0]
    cie_a = Math.cos(Math.radians(cielch[2])) * cielch[1]
    cie_b = Math.sin(Math.radians(cielch[2])) * cielch[1]
    return [cie_l,cie_a,cie_b]
  end

  def cielch_to_rgb(cielch)
    # convert CIE-L*CH^o array to XYZ array
    return xyz_to_rgb(cielab_to_xyz(cielch_to_cielab(cielch)))
  end
end