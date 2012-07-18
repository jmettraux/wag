
#
# spec/spec_helper.rb
#

SDIR = File.expand_path('..', __FILE__)

WAG_VERSION = File.read(
    File.expand_path('../../lib/wag', __FILE__)
).match(/ VERSION *= *['"]([^'"]+)/)[1]


module WagHelper

  def wag(line)

    ENV['WAG_TEST'] = 'true'
    ENV['WAG_HOME'] = "#{SDIR}/fixtures/vagdir"
    ENV['WAG_VMAN'] = "bundle exec ruby #{SDIR}/faker.rb -vboxmanage"
    ENV['WAG_VAG'] = "bundle exec ruby #{SDIR}/faker.rb -vagrant"

    w = File.expand_path('../../lib/wag', __FILE__)

    `#{w} #{Array(line).join(' ')} 2>&1`.strip
  end
end


RSpec.configure do |config|

  #config.mock_framework = :rspec

  config.include WagHelper
end

