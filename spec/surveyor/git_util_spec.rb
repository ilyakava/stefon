require 'spec_helper'

describe Stefon::Surveyor::GitUtil do
  describe '#lines_by_file' do
    it 'correctly yields lines belonging to files'
  end

  describe '#diff_as_array' do
    it 'correctly formats git diff output for + mode'
    it 'correctly formats git diff output for - mode'
    it 'correctly formats git diff output without a mode set'
  end

  describe '#top_commiter' do
    it "doesn't return any authors that are excluded"
  end
end