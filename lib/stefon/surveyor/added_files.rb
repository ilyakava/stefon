module Stefon
  module Surveyor
    class AddedFiles < Surveyor
      def call
        score_added_files
      end

      def score_added_files
        if (num_added_files = @repo.status.added.count) > 0
          @scores[@top_commiter] += num_added_files
        end
        @scores
      end
    end
  end
end