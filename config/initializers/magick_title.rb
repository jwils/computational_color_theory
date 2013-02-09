


border_width = 0 #10
border_height = 0 #100

DEFAULT_IMG_TEXT = """
  If it moved Northward, the
  Southern points in the
  Square would have to
  move through the positions
  previously occupied by the
  Northern points. But that
  is not my meaning."""

MagickTitle.options[:font] = 'Arial.tff'
MagickTitle.options[:width] = 400 - 2*border_width
MagickTitle.options[:height] = 500 - 2*border_height
MagickTitle.options[:font_size] = 30
MagickTitle.options[:background_alpha] = '100'
MagickTitle.options[:font_path] = Proc.new{ File.join MagickTitle.root, "fonts" }
MagickTitle.options[:destination] = Proc.new{ File.join MagickTitle.root, "public/exp_img" }

BORDER = "#{border_width}x#{border_height}"

MagickTitle::Image.class_eval do
  def cmd(command, params)
    [path_for_command(command), "-border #{BORDER} " + params.to_s.gsub(/\\|\n|\r/, '')].join(" ")
  end
end