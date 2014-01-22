module Stefon
  # The editor is responsible for forming a team of surveyors and
  # asking for and combining their results. The editor decides what story
  # to run, i.e. to print recommendations or why recommendations are impossible
  class Editor
    attr_reader :excluded_authors, :weights
    attr_accessor :errors

    # The editor has a team of surveyors
    TEAM = [
      AddedFiles.new,
      AddedLines.new,
      DeletedFiles.new,
      DeletedLines.new
    ]

    def initialize(config)
      self.excluded_authors = config.excluded_authors
      self.weights = config.weights
      self.errors = []
    end


    # The editor weights the importance of each surveyor's report
    def combine_reports
      # delete excluded authors at this point
      aggregate = TEAM.collect(Surveyor::SurveyorStore.new) { |a, e| a.merge_scores(e.call) }
    end

    def summarize_results
      combine_reports.sort_by { |k, v| v }.first(5).map(&:last).flatten
    end
  end
end
