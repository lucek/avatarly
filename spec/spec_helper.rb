require 'rspec'
require 'avatarly'
require 'chunky_png'
require 'support/avatar_expectations'

RSpec.configure do |config|
  config.include AvatarExpectations
end
