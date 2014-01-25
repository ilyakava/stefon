module Stefon
  module Surveyor
    class DeletedLines < Surveyor::Base
      def call
        score_deleted_lines
      end

      def score_deleted_lines
        deleted_lines_by_file.each_pair do |filename, lines|
          blame = @@grit.blame_for(filename)
          lines.each do |deleted_line|
            valid_author = @@gritvalid_line_author(blame, line)
            @scores[valid_author] += 1 if valid_author
          end
        end
        @scores
      end

      def deleted_lines_by_file
        lines_by_file_store = Hash.new([])
        git_diff_as_array = GitUtil.diff_as_array('-')
        filename_marker = '--'
        GitUtil.lines_by_file(git_diff_as_array, filename_marker) do |filename, line_in_file|
          lines_by_file_store[filenames] += [line_in_file]
        end
        lines_by_file_store
      end
    end
  end
end