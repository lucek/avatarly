Gem::Specification.new do |s|
  s.add_runtime_dependency('rmagick')
  s.add_runtime_dependency('rfc822')
  s.add_runtime_dependency('unicode_utils')

  s.name        = "avatarly"
  s.version     = "1.6.1"
  s.summary     = "Simple gem for creating gmail-like user avatars with initials."
  s.description = "Avatarly is a simple gem for Ruby that creates gmail-like avatars with initials, inspired by avatar-generator by johnnyhalife. See homepage for more information."
  s.authors     = ["Lukasz Odziewa", "Artur Trzop"]
  s.email       = "lukasz.odziewa@gmail.com"
  s.files       = ["README.md", "LICENSE", "Gemfile", "lib/avatarly.rb", "assets/fonts/Roboto.ttf"]
  s.homepage    = "https://github.com/lucek/avatarly"
  s.license     = "MIT"
end
