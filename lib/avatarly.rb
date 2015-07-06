require 'rvg/rvg'
require 'rfc822'
require 'pathname'

class Avatarly
  BACKGROUND_COLORS = [
      "#f68185", "#7e6275", "#cc5c33", "#506e96", "#8375a5", "#8bc859",
      "#a78b79", "#52c0b6", "#839493", "#fc5d44", "#61a0ab", "#f59829"
    ].freeze

  class << self
    def generate_avatar(text, opts={})
      generate_image(initials(text.to_s.gsub(/\W/,' ')).upcase, parse_options(opts)).to_blob
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
