# encoding: utf-8

module Stefon
  module Surveyor
    # This class gives points to the top commiter of the repo
    # proportionally to each file that a user adds
    class AddedFiles < Surveyor::Base
      def call
        score_added_files.weight_scores(@weight)
      end

      def call_verbose
        # There is only 1 top commiter
        author = GitUtil.top_commiter.first
        Surveyor::SurveyorStore[[
          [author, ["The top commiter in this repo is: #{author}"]]
        ]]
      end

      def score_added_files
        if (num_added_files = @@grit.repo.status.added.count) > 0
          @scores[GitUtil.top_commiter] += num_added_files
        end
        @scores
      end
    end
  end
end
