# encoding: utf-8

require 'spec_helper'
require 'fakefs/safe'

describe Stefon::Surveyor::GritUtil do
  context 'when there is no git repo in the current directory' do
    before :each do
      Grit::Repo.any_instance.stub(:commits).and_return([])
    end
    around :each do |example|
      @randomizer = (1..99_999).to_a.sample # FakeFS doesn't reset btw tests!
      FakeFS do
        Dir.mkdir "/repo_root_#{@randomizer}"
        Dir.mkdir "/repo_root_#{@randomizer}/1_dir_too_deep"
        Dir.mkdir "/repo_root_#{@randomizer}/1_dir_too_deep/2_dirs_too_deep"
        Dir.chdir "/repo_root_#{@randomizer}/1_dir_too_deep/2_dirs_too_deep"
        example.run
      end
    end
    it 'can still initialize if there is a git repo in a parent directory' do
      Dir.mkdir "/repo_root_#{@randomizer}/.git/"
      grit = Stefon::Surveyor::GritUtil.new
      grit.repo.should_not be_nil
    end

    it 'raises an error if there is no git repo in parent directories' do
      expect do
        Stefon::Surveyor::GritUtil.new
      end.to raise_error 'Could not find a git repository!'
    end
  end
end
