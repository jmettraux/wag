
require 'spec_helper'


describe 'wag' do

  describe 'wag xxx' do

    it 'is rejected as an unknown command' do

      wag('xxx').should match(/unknown command "xxx"/)
    end
  end

  describe 'wag -v' do

    it 'returns the version' do

      (wag '-v').should == WAG_VERSION
    end
  end

  describe 'wag --version' do

    it 'returns the version' do

      (wag '--version').should == WAG_VERSION
    end
  end

  def assert(x)

    return true if x

    line = caller.first.match(/rb:(\d+):in /)[1].to_i

    raise(
      "failed assertion: " +
      "line #{line}: " +
      File.readlines(__FILE__)[line - 1])
  end

  def validate_help(s)

    ss = s.split("\n")

    assert ss.find { |l| l.match(/ wag -v$/) }
    assert ss.find { |l| l.match(/ wag NICK poweroff/) }
    assert ss.find { |l| l.match(/ hard VBoxManage poweroff /) }
    assert ( ! ss.find { |l| l.match(/ :nodoc: /) })
    assert ( ! ss.find { |l| l.match(/ wag -v ARGS\*$/) })
  end

  describe 'wag -h' do

    it 'prints the usage' do

      r = wag '-h'

      validate_help(r).should == true
    end
  end

  describe 'wag --help' do

    it 'prints the usage' do

      r = wag '--help'

      validate_help(r).should be_true
    end
  end

  describe 'wag help' do

    it 'prints the usage' do

      r = wag 'help'

      validate_help(r).should be_true
    end
  end

  describe 'wag _env' do

    it 'prints WAG_ environment variables' do

      r = wag '_env'

      r.split("\n").first.should == "WAG_HOME: \"#{SDIR}/fixtures/vagdir\""
    end
  end

  describe 'wag _consts' do

    it 'prints info about the wag constants' do

      r = wag '_consts'

      r.split("\n")[-2].should match(/faker\.rb -vboxmanage"$/)
    end
  end

  describe 'wag vms' do

    it 'prints the list of managed vms' do

      r = wag 'vms'

      r.should == %{
NICK                NAME                UUID
vm                  vm_1234             12345678-1234-1234-1234-123456789000
      }.strip
    end
  end

  describe 'wag boxes' do

    it 'prints the list of boxes available' do

      r = wag 'boxes'

      r.should == %{
squeeze64
redhat5_2
      }.strip
    end
  end

  describe 'wag vm' do

    it 'makes sure the vm is up and then sshs into it' do

      r = wag 'vm'

      rr = r.split("\n")
      rr[0].should == "-vagrant #{SDIR}/fixtures/vagdir/vm up"
      rr[1].should == "-vagrant #{SDIR}/fixtures/vagdir/vm ssh"
    end
  end

  describe 'wag vm ssh-config' do

    it 'prints the ssh-config for the vm' do

      r = wag 'vm ssh-config'

      r.should == "-vagrant #{SDIR}/fixtures/vagdir/vm ssh-config"
    end
  end

  describe 'wag vm ssh' do

    it 'sshs into the vm' do

      r = wag 'vm ssh'

      r.should == "-vagrant #{SDIR}/fixtures/vagdir/vm ssh"
    end
  end

  describe 'wag vm poweroff' do

    it 'powers off the vm' do

      r = wag 'vm poweroff'

      r.should == "-vboxmanage controlvm vm_1234 poweroff"
    end
  end

  describe 'wag vm network' do

    it 'displays the network settings out of the Vagrantfile' do

      r = wag 'vm network'

      r.should == "config.vm.network :hostonly, '10.0.2.7'"
    end
  end
end

