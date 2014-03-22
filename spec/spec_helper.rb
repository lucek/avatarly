require 'rspec'
require 'avatarly'
require 'chunky_png'

module AvatarExpectations
  def image_from_blob(blob)
    ChunkyPNG::Image.from_blob(blob)
  end

  def resource_file(name)
    File.expand_path("./resources/#{name}", File.dirname(__FILE__))
  end

  def reference_image(name)
    ChunkyPNG::Image.from_file(resource_file("#{name}.png"))
  end
end

RSpec.configure do |config|
  config.include AvatarExpectations
end
