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

  class << self
    def generate_avatar(text, opts={})
      generate_image(initials(text.to_s).upcase, parse_options(opts)).to_blob
    end

    def root
      File.expand_path '../..', __FILE__
    end

    def lib
      File.join root, 'lib'
    end

    private

    def fonts
      File.join root, 'assets/fonts'
    end

    def generate_image(text, opts)
      image = Magick::RVG.new(opts[:size], opts[:size]).viewbox(0, 0, opts[:size], opts[:size]) do |canvas|
        canvas.background_fill = opts[:background_color]
      end.draw
      image.format = opts[:format]
      draw_text(image, text, opts)
      image
    end

    def draw_text(canvas, text, opts)
      Magick::Draw.new do
        self.pointsize = opts[:font_size]
        self.font = opts[:font]
        self.fill = opts[:font_color]
        self.gravity = Magick::CenterGravity
      end.annotate(canvas, 0, 0, 0, 0, text)
    end

    def initials(text)
      if text.is_email?
        initials_for_separator(text.split("@").first, ".")
      elsif text.include?(" ")
        initials_for_separator(text, " ")
      else
        initials_for_separator(text, ".")
      end
    end

    def initials_for_separator(text, separator)
      if text.include?(separator)
        text = text.split(separator)
        text[0][0] + text[1][0]
      else
        text[0][0]
      end
    end

    def default_options
      { background_color: BACKGROUND_COLORS.sample,
        font_color: '#FFFFFF',
        size: 32,
        font: "#{fonts}/Roboto.ttf",
        format: "png" }
    end

    def parse_options(opts)
      opts = default_options.merge(opts)
      opts[:size] = opts[:size].to_i
      opts[:font] = default_options[:font] unless Pathname(opts[:font]).exist?
      opts[:font_size] ||= opts[:size] / 2
      opts[:font_size] = opts[:font_size].to_i
      opts
    end
  end
end
