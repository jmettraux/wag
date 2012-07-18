
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

  describe 'wag -h' do

    it 'prints the usage'
  end

  describe 'wag help' do

    it 'prints the usage'
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

  describe 'wag vm' do

    it 'makes sure the vm is up and then sshs into it' do

      r = wag 'vm'

      rr = r.split("\n")
      rr[0].should == "#{SDIR}/fixtures/vagdir/vm up"
      rr[1].should == "#{SDIR}/fixtures/vagdir/vm ssh"
    end
  end

  describe 'wag vm ssh' do

    it 'sshs into the vm' do

      r = wag 'vm ssh'

      r.should == "#{SDIR}/fixtures/vagdir/vm ssh"
    end
  end
end

