# encoding: utf-8

require 'spec_helper'

describe Stefon::Surveyor::GitUtil do
  describe '#lines_by_file' do
    let(:git_diff_as_array) do
      [
        '-- a/bin/stefon',
        '-- a/lib/stefon/surveyor/deleted_lines.rb',
        '-- a/lib/stefon/surveyor/git_util.rb',
        'block.call(line, next_line)',
        '-- a/spec/surveyor/git_util_spec.rb',
        'describe Stefon::Surveyor::GitUtil do',
        'describe "#lines_by_file" do',
        'it "correctly yields lines belonging to files"',
        'end'
      ]
    end
    let(:right_structure) do
      {
        'lib/stefon/surveyor/git_util.rb' => ['block.call(line, next_line)'],
        'spec/surveyor/git_util_spec.rb' => [
          'describe Stefon::Surveyor::GitUtil do',
          'describe "#lines_by_file" do',
          'it "correctly yields lines belonging to files"',
          'end'
        ]
      }
    end
    let(:save_structure) { Hash.new([]) }
    let(:block) { ->(filename, line) { save_structure[filename] += [line] } }

    it 'correctly yields lines belonging to files' do
      Stefon::Surveyor::GitUtil.lines_by_file(git_diff_as_array, '--', block)
      save_structure.should == right_structure
    end
  end

  describe '#diff_as_array' do
    it 'correctly formats git diff output for - mode' do
      pending('Would test this, but relies on console methods like sed')
    end
  end

  describe '#top_commiter' do
    it 'returns the top commiter for a repo' do
      pending('Would test this, but relies on console methods like sed')
    end
  end
end
