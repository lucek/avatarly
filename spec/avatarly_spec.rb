require 'spec_helper'

describe Avatarly do
  describe '.generate_avatar' do
    it 'generates avatar for given email address' do
      result = described_class.generate_avatar("hello.world@example.com",
                                               background_color: "#000000")
      assert_image_equality(result, :HW_black_white_32, 34)
    end

    it 'accepts parameters for size and background and font colors' do
      result = described_class.generate_avatar("hello.world@example.com",
                                               background_color: "#FFFFFF",
                                               font_color: "#000000",
                                               size: 64)
      assert_image_equality(result, :HW_white_black_64, 38)
    end

    context 'accepts parameters for format' do
      it '.png'  do
        result = described_class.generate_avatar("hello.world@example.com",
                                                 format: "png")
        assert_image_format(result, :png)
      end

      it '.jpg' do
        result = described_class.generate_avatar("hello.world@example.com",
                                                 format: "jpeg")
        assert_image_format(result, :jpeg)
      end
    end

    context 'non-email input' do
      it 'uses first letters of first two space separated words' do
        result = described_class.generate_avatar("hello World",
                                                 background_color: "#000000")
        assert_image_equality(result, :HW_black_white_32, 34)
      end

      it 'falls back to dot-separated words when no spaces in input' do
        result = described_class.generate_avatar("hello.World",
                                                 background_color: "#000000")
        assert_image_equality(result, :HW_black_white_32, 34)
      end

      it 'falls back to single-letter avatar when no dots and spaces found' do
        result = described_class.generate_avatar("HelloWorld",
                                                 background_color: "#000000")
        assert_image_equality(result, :H_black_white_32)
      end

      it 'does not break if input has leading or trailing space' do
        result = described_class.generate_avatar(" HelloWorld ",
                                                 background_color: "#000000")
        assert_image_equality(result, :H_black_white_32)
      end

      it 'does not break if input has leading or trailing non-word character' do
        result = described_class.generate_avatar("%HelloWorld!",
                                                 background_color: "#000000")
        assert_image_equality(result, :H_black_white_32)
      end

      it 'strips leading/trailing whitespace without striping other whitespaces' do
        expect(described_class).to receive(:initials).with('Hello World').and_return 'HW'
        described_class.generate_avatar(' Hello World! ')
      end
    end
  end
end
