# encoding: utf-8

module Stefon
  module Surveyor
    class AddedFiles < Surveyor::Base
      def call
        score_added_files
      end

      def call_verbose
        # There is only 1 top commiter
        author = GitUtil.top_commiter.first
        Surveyor::SurveyorStore[[[author, ["The top commiter in this repo is: #{author}"]]]]
      end

      def score_added_files
        if (num_added_files = @@grit.repo.status.added.count) > 0
          @scores[GitUtil.top_commiter] += num_added_files * @weight
        end
        @scores
      end
    end
  end
end
