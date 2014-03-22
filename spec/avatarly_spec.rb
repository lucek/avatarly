require 'spec_helper'

describe Avatarly do
  describe '.generate_avatar' do
    it 'generates avatar for given email address' do
      result = image_from_blob(described_class.generate_avatar("hello.world@example.com",
                                                               background_color: "#000000"))
      result.should == reference_image(:HW_black_white_32)
    end

    it 'accepts parameters for size and background and font colors' do
      result = image_from_blob(described_class.generate_avatar("hello.world@example.com",
                                                               background_color: "#FFFFFF",
                                                               font_color: "#000000",
                                                               size: 64))
      result.should == reference_image(:HW_white_black_64)
    end
  end
end
