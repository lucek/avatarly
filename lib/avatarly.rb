require 'rvg/rvg'
require 'rfc822'

class Avatarly
  BACKGROUND_COLORS = [ 
      "#ff4040", "#7f2020", "#cc5c33", "#734939", "#bf9c8f", "#995200", 
      "#4c2900", "#f2a200", "#ffd580", "#332b1a", "#4c3d00", "#ffee00", 
      "#b0b386", "#64664d", "#6c8020", "#c3d96c", "#143300", "#19bf00", 
      "#53a669", "#bfffd9", "#40ffbf", "#1a332e", "#00b3a7", "#165955", 
      "#00b8e6", "#69818c", "#005ce6", "#6086bf", "#000e66", "#202440", 
      "#393973", "#4700b3", "#2b0d33", "#aa86b3", "#ee00ff", "#bf60b9", 
      "#4d3949", "#ff00aa", "#7f0044", "#f20061", "#330007", "#d96c7b" 
    ].freeze

  def self.generate_avatar(text, opts={})
    text             = text.to_s
    background_color = opts[:background_color]                      ? opts[:background_color] : BACKGROUND_COLORS.sample
    font_color       = opts[:font_color]                            ? opts[:font_color]       : '#FFFFFF'
    size             = opts[:size]                                  ? opts[:size].to_i        : 32
    font             = opts[:font] && Pathname(opts[:font]).exist?  ? opts[:font].to_s        : "#{lib}/Roboto.ttf"
    font_size        = opts[:font_size]                             ? opts[:font_size].to_i   : size / 2

    if text.dup.is_email? #duplicate used due to the fact that is_email? method changes encoding to binary
      text = text.split("@").first

      if text.include?(".")
        text = text.split(".")
        text = text[0][0] + text[1][0]
      else
        text = text[0][0]
      end
    else
      text = text.split(" ")

      if text.size > 1
        text = text[0][0] + text[1][0]
      else
        text = text.first.split(".")

        if text.size > 1
          text = text[0][0] + text[1][0]
        else
          text = text[0][0]
        end
      end
    end

    text = text.upcase

    rvg = Magick::RVG.new(size, size).viewbox(0, 0, size, size) do |canvas|
      canvas.background_fill = background_color
    end

    img = rvg.draw
    img.format = 'png'

    drawable = Magick::Draw.new
    drawable.pointsize = font_size
    drawable.font = font
    drawable.fill = font_color
    drawable.gravity = Magick::CenterGravity
    drawable.annotate(img, 0, 0, 0, 0, text)

    return img.to_blob
  end

  def self.root
    File.expand_path '../..', __FILE__
  end

  def self.lib
    File.join root, 'lib'
  end
end
