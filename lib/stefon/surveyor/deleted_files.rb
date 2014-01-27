# encoding: utf-8

module Stefon
  module Surveyor
    # This class gives points to the predominant author of a file
    # that a user deletes
    class DeletedFiles < Surveyor::Base
      def call
        score_deleted_files.weight_scores(@weight)
      end

      def call_verbose
        array_version = score_deleted_files.to_a.map do |pair|
          desc = "Deleted #{pair.last} #{pair.last == 1 ? 'file' : 'files' } " +
            "written by: #{pair.first}"
          [pair.first, [desc]]
        end
        Surveyor::SurveyorStore[array_version]
      end

      def score_deleted_files
        @@grit.repo.status.deleted.keys.each do |filename|
          blame = @@grit.blame_for(filename)
          top_author = @@grit.file_valid_top_author(blame, filename)
          @scores[top_author] += 1
        end
        @scores
      end
    end
  end
end
