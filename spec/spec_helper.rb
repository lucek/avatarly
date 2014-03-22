require 'rspec'
require 'avatarly'
require 'chunky_png'

module AvatarExpectations
  def resource_file(name)
    File.expand_path("./resources/#{name}", File.dirname(__FILE__))
  end

  def reference_image(name)
    ChunkyPNG::Image.from_file(resource_file("#{name}.png")).to_blob
  end

  def assert_image_equality(first, second)
    ChunkyPNG::Image.from_blob(first).should == ChunkyPNG::Image.from_blob(second)
  end
end

RSpec.configure do |config|
  config.include AvatarExpectations
end
