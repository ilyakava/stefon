# encoding: utf-8

module Stefon
  module Surveyor
    # A module of usefull utils for dealing with the git cli directly
    module GitUtil
      CURRENT_BRANCH ||= %x(git rev-parse --abbrev-ref HEAD).sub("\n", "")

      def self.top_commiter
        git_commiters = %x(git shortlog -s -n)
        # make a hash of authors pointing to num commits
        top_commiters = Hash[git_commiters.split("\n").map { |numcommits_author| numcommits_author.strip.split("\t").reverse }]
        top_commiters.sort_by { |a, numlines| numlines.to_i }.first
      end

      def self.diff_as_array(mode = nil)
        # mode should be '+' for added lines, '-' for deleted lines, and none for all
        # looks at a diff, optionally matches lines starting with mode char, cut off first char of each line
        %x(git diff HEAD~#{GritUtil.new.num_sui_commits} -U0 | #{mode ? "grep ^#{mode} | " : ""} sed 's/^.//').split("\n").map(&:strip)
      end

      def self.added_lines_by_file(&block)
        lines_by_file(diff_as_array('+'), '++', block)
      end

      def self.deleted_lines_by_file(&block)
        lines_by_file(diff_as_array('-'), '--', block)
      end

      def self.lines_by_file(git_diff_as_array, filename_marker, block)
        # delivers a line and its parent filename to a block
        git_diff_as_array.each_with_index do |e, i|
          line, lines_ahead = e, 1
          # if the line is a filename, we want it to point to its lines
          while (line[0..1] == filename_marker) && (i + lines_ahead < git_diff_as_array.length) do
            next_line = git_diff_as_array[i + lines_ahead]
            # next_lines should not be filenames
            break if next_line[0..1] == filename_marker
            block.call(line[5..-1], next_line)
            lines_ahead += 1
          end
        end
      end
    end
  end
end
