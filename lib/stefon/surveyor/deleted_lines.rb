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
            valid_author = @@grit.valid_line_author(blame, deleted_line)
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
