# encoding: utf-8

module Stefon
  # The editor is responsible for forming a team of surveyors and
  # asking for and combining their results. The editor decides what story
  # to run, i.e. to print recommendations or why recommendations are impossible
  class Editor
    attr_reader :options, :team
    attr_accessor :errors

    def initialize(options)
      @options = options
      # currently unused
      @errors = []
      # The editor has a team of surveyors, and tells them their importance
      @team = [
        Surveyor::AddedFiles.new(options[:added_file]),
        Surveyor::AddedLines.new(options[:added_line]),
        Surveyor::DeletedFiles.new(options[:deleted_file]),
        Surveyor::DeletedLines.new(options[:deleted_line])
      ]
    end

    def combine_short_reports
      @team.reduce(Surveyor::SurveyorStore.new) do |a, e|
        a.merge_scores(e.call)
      end
    end

    def short_report
      combine_short_reports.sort_by { |k, v| -v }
    end

    def combine_full_reports
      @team.reduce(Surveyor::SurveyorStore.new([])) do |a, e|
        a.merge_scores(e.call_verbose)
      end
    end

    def full_report
      # sort by the scores
      combine_full_reports.sort_by { |k, v| -combine_short_reports[k] }
    end

    def summarize_results
      if @options[:full_report]
        full_report.first(@options[:limit]).map(&:last).flatten
      else
        short_report.first(@options[:limit]).map(&:first).flatten
      end
    end
  end
end
