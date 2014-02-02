# encoding: utf-8

require 'spec_helper'

describe Stefon::Config do

  describe 'reading configuration from files' do
    it 'reads the default configuration'
    it 'read the user provided configuration'
  end

  describe 'loading configuration from github' do
    it 'can connect and form a list of users to filter by'
  end

  context 'without github options enabled' do
    describe 'merging configurations' do
      it 'ensures user configuration takes prescedence'
    end
  end

  context 'with github enabled' do
    describe 'merging configurations' do
      it 'ensures user github config takes prescedence over user yml config'
    end
  end
end
