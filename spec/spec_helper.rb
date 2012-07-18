
SDIR = File.expand_path('..', __FILE__)

VERSION = File.read(
    File.expand_path('../../lib/wag', __FILE__)
).match(/ VERSION *= *['"]([^'"]+)/)[1]


module WagHelper

  def wag(line)

    ENV['WAG_TEST'] = 'true'

    w = File.expand_path('../../lib/wag', __FILE__)

    `#{w} #{Array(line).join(' ')} 2>&1`.strip
  end
end


RSpec.configure do |config|

  #config.mock_framework = :rspec
  config.include WagHelper
end

