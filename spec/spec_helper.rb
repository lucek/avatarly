require 'rspec'
require 'avatarly'
require 'phashion'
require 'support/avatar_expectations'
require 'fastimage'
require 'tempfile'

RSpec.configure do |config|
  config.include AvatarExpectations
end
