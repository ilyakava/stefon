module Stefon
  module Surveyor
    class DeletedFiles < Surveyor
      def call
        score_deleted_files
      end

      def score_deleted_files
        if (num_deleted_files = @repo.status.added.count) > 0
          @scores[top_commiter] += num_deleted_files
        end
        @scores
      end
    end
  end
end