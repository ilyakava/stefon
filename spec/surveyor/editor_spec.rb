# encoding: utf-8

require 'spec_helper'

describe 'Editor' do
  let(:options) do
    {
      limit: 4,
      deleted_line: 2,
      deleted_file: 4,
      added_line: 1,
      added_file: 1
    }
  end

  describe 'summarize results (integration)' do
    before(:each) do
      [
        Stefon::Surveyor::AddedFiles,
        Stefon::Surveyor::AddedLines,
        Stefon::Surveyor::DeletedFiles,
        Stefon::Surveyor::DeletedLines
      ].each do |klass|
        klass.any_instance.stub(:call).and_return(
          'Cy Twombly' => 4,
          'Christian Boltanski' => 2
        )
        klass.any_instance.stub(:call_verbose).and_return(
          'Cy Twombly' => ['Deleted 4 lines by Cy Twombly'],
          'Christian Boltanski' => ['Deleted 2 lines by Christian Boltanski']
        )
      end
    end

    it 'does not include numbers in the short report' do
      options[:full_report] = false
      editor = Stefon::Editor.new(options)
      results = editor.summarize_results
      results.should include 'Cy Twombly'
      results.should include 'Christian Boltanski'
      results.each do |reported_result|
        reported_result.should_not =~ /\d/
      end
    end

    it 'reports numbers in the verbose report' do
      options[:full_report] = true
      editor = Stefon::Editor.new(options)
      results = editor.summarize_results
      results.should include('Deleted 4 lines by Cy Twombly')
      results.should include('Deleted 2 lines by Christian Boltanski')
      results.each do |reported_result|
        unless reported_result =~ /The top commiter in this repo is/
          reported_result.should =~ /\d/
        end
      end
    end
  end
end
