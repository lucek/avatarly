module AvatarExpectations
  def resource_file(name)
    File.expand_path("../../fixtures/#{name}", __FILE__)
  end

  def assert_image_equality(actual_image_blob, expected_image_name, hamming_distance = 2)
    actual_image_path = resource_file('temp_generated_image.png')
    expected_image_path = resource_file("#{expected_image_name}.png")

    File.open(actual_image_path, 'wb') do |f|
      f.write actual_image_blob
    end

    actual_image = Phashion::Image.new(actual_image_path)
    expected_image = Phashion::Image.new(expected_image_path)

    result = actual_image.duplicate?(expected_image, threshold: hamming_distance)

    unless result
      puts "Hamming distance between two images: #{actual_image.distance_from(expected_image)}. Required at least #{hamming_distance}."
    end

    expect(result).to be true

    File.delete(actual_image_path)
  end

  def assert_image_format(image, format)
    temp_file = Tempfile.new('avatarly')
    File.open(temp_file, 'wb') do |f|
      f.write image
    end

    expect(FastImage.type(temp_file)).to eql(format)
  end
end
