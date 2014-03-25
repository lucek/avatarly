require 'spec_helper'

describe Avatarly do
  describe '.generate_avatar' do
    it 'generates avatar for given email address' do
      result = described_class.generate_avatar("hello.world@example.com",
                                               background_color: "#000000")
      assert_image_equality(result, reference_image(:HW_black_white_32))
    end

    it 'accepts parameters for size and background and font colors' do
      result = described_class.generate_avatar("hello.world@example.com",
                                               background_color: "#FFFFFF",
                                               font_color: "#000000",
                                               size: 64)
      assert_image_equality(result, reference_image(:HW_white_black_64))
    end

    context 'non-email input' do
      it 'uses first letters of first two space separated words' do
        result = described_class.generate_avatar("hello World",
                                                 background_color: "#000000")
        assert_image_equality(result, reference_image(:HW_black_white_32))
      end

      it 'falls back to dot-separated words when no spaces in input' do
        result = described_class.generate_avatar("hello.World",
                                                 background_color: "#000000")
        assert_image_equality(result, reference_image(:HW_black_white_32))
      end

      it 'falls back to single-letter avatar when no dots and spaces found' do
        result = described_class.generate_avatar("HelloWorld",
                                                 background_color: "#000000")
        assert_image_equality(result, reference_image(:H_black_white_32))
      end
    end
  end
end
