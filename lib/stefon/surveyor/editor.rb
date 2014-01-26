# encoding: utf-8

module Stefon
  # The editor is responsible for forming a team of surveyors and
  # asking for and combining their results. The editor decides what story
  # to run, i.e. to print recommendations or why recommendations are impossible
  class Editor
    attr_reader :weights
    attr_accessor :errors

    # The editor has a team of surveyors
    TEAM = [
      Surveyor::AddedFiles.new,
      Surveyor::AddedLines.new,
      Surveyor::DeletedFiles.new,
      Surveyor::DeletedLines.new
    ]

    def initialize(weights)
      @weights = weights
      @errors = []
    end


    # The editor weights the importance of each surveyor's report
    def combine_reports
      TEAM.reduce(Surveyor::SurveyorStore.new) do |a, e|
        a.merge_scores(e.call)
      end
    end

    def summarize_results
      combine_reports.sort_by { |k, v| v }.first(3).map(&:last).flatten
    end
  end
end
