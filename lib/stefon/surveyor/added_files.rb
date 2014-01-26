# encoding: utf-8

module Stefon
  module Surveyor
    class AddedFiles < Surveyor::Base
      def call
        score_added_files
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
