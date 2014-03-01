require 'rvg/rvg'

class Avatarly
  def self.draw_square(text, size, background, font_color)
    background ||= '#000000'
    font_color ||= '#FFFFFF'

    if text.is_email?
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
        text = text[0][0]
      end
    end

    text = text.upcase

    rvg = Magick::RVG.new(size, size).viewbox(0, 0, size, size) do |canvas|
      canvas.background_fill = background
    end

    img = rvg.draw
    img.format = 'png'

    drawable = Magick::Draw.new
    drawable.pointsize = size / 2
    drawable.fill = font_color
    drawable.font_family = "Arial"
    drawable.gravity = Magick::CenterGravity
    drawable.font_weight = Magick::BoldWeight
    drawable.annotate(img, 0, 0, 0, 0, text)

    return img.to_blob
  end
end