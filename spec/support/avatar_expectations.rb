module AvatarExpectations
  def resource_file(name)
    File.expand_path("../../fixtures/#{name}", __FILE__)
  end

  def reference_image(name)
    ChunkyPNG::Image.from_file(resource_file("#{name}.png")).to_blob
  end

  def assert_image_equality(first, second)
    expect(ChunkyPNG::Image.from_blob(first)).to eql ChunkyPNG::Image.from_blob(second)
  end
end

