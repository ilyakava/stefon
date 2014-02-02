# encoding: utf-8

module Stefon
  module Surveyor
    # This class gives points to authors of lines that the user deletes
    class DeletedLines < Surveyor::Base
      def call
        score_deleted_lines.weight_scores(@weight)
      end

      def call_verbose
        array_version = score_deleted_lines.to_a.map do |pair|
          desc = "Deleted #{pair.last} #{pair.last == 1 ? 'line' : 'lines' }" +
            " written by: #{pair.first}"
          [pair.first, [desc]]
        end
        Surveyor::SurveyorStore[array_version]
      end

      def score_deleted_lines
        deleted_lines_by_file.each_pair do |filename, lines|
          blame = @grit.blame_for(filename)
          lines.each do |deleted_line|
            valid_author = @grit.valid_line_author(blame, deleted_line)
            @scores[valid_author] += 1 if valid_author
          end
        end
        @scores
      end

      def deleted_lines_by_file
        lines_by_file_store = Hash.new([])
        GitUtil.deleted_lines_by_file do |filename, line_in_file|
          lines_by_file_store[filename] += [line_in_file]
        end
        lines_by_file_store
      end
    end
  end
end
