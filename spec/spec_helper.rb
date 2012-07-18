
#
# spec/spec_helper.rb
#

SDIR = File.expand_path('..', __FILE__)

WAG_VERSION = File.read(
    File.expand_path('../../lib/wag', __FILE__)
).match(/ VERSION *= *['"]([^'"]+)/)[1]


module WagHelper

  def wag(line, dir=false)

    ENV['WAG_TEST'] = 'true'
    ENV['WAG_HOME'] = "#{SDIR}/fixtures/vagdir"
    ENV['WAG_VMAN'] = "bundle exec ruby #{SDIR}/faker.rb -vboxmanage"
    ENV['WAG_VAG'] = "bundle exec ruby #{SDIR}/faker.rb -vagrant"

    dir = dir && File.join(ENV['WAG_HOME'], 'vm')

    w = File.expand_path('../../lib/wag', __FILE__)

    args = if line.is_a?(Array)
      line.collect { |a| a.match(/\s/) ? a.inspect : a }.join(' ')
    else
      line
    end

    if dir
      #puts "cd #{dir} && #{w} #{args} 2>&1"
      `cd #{dir} && #{w} #{args} 2>&1`.strip
    else
      #puts "#{w} #{args} 2>&1"
      `#{w} #{args} 2>&1`.strip
    end
  end
end


RSpec.configure do |config|

  #config.mock_framework = :rspec

  config.include WagHelper
end

