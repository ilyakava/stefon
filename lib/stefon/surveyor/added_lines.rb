# encoding: utf-8

module Stefon
  module Surveyor
    # This class gives points to the top author of a file in which
    # a user deleted lines
    class AddedLines < Surveyor::Base
      def call
        score_added_lines.weight_scores(@weight)
      end

      def call_verbose
        array_version = score_added_lines.to_a.map do |pair|
          desc = "Added #{pair.last} #{pair.last == 1 ? 'line' : 'lines' } " +
            "to files written by: #{pair.first}"
          [pair.first, [desc]]
        end
        Surveyor::SurveyorStore[array_version]
      end

      def score_added_lines
        # give credit to the most frequent commiter in the file
        added_lines_by_file.each_pair do |filename, numlines|
          blame = @@grit.blame_for(filename)
          top_author = @@grit.file_valid_top_author(blame, filename)
          # multiplied by the number of lines that are added in the staged commit
          @scores[top_author] += numlines
        end
        @scores
      end

      def added_lines_by_file
        lines_per_file_store = Hash.new(0)
        GitUtil.added_lines_by_file do |filename, line_in_file|
          lines_per_file_store[filename] += 1
        end
        lines_per_file_store
      end
    end
  end
end
