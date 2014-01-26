# encoding: utf-8

module Stefon
  module Surveyor
    class DeletedFiles < Surveyor::Base
      def call
        score_deleted_files
      end

      def call_verbose
        # The top commiter in this repo is already mentioned in AddedFiles
        Surveyor::SurveyorStore.new
      end

      def score_deleted_files
        if (num_deleted_files = @@grit.repo.status.added.count) > 0
          @scores[GitUtil.top_commiter] += num_deleted_files * @weight
        end
        @scores
      end
    end
  end
end
