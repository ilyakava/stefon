module Stefon
  module Surveyor
    # A class that abstracts dealing with the grit gem
    class GritUtil
      attr_reader :repo

      CURRENT_USER = @repo.config["user.name"]

      def initialize
        self.repo = Grit::Repo.new(".")
        commits = @repo.commits(GitUtil.CURRENT_BRANCH)
        @num_sui_commits = commits.find_index { |c| c.author.name != CURRENT_USER }
        @last_xeno_commit = commits[@num_sui_commits]
      end

      def blame_for(filename)
        repo.blame(filename, @last_xenocommit)
      end

      def line_author(blame, line)
        matched_line = blame.lines.detect { |l| l.line.strip == line }
        matched_line.commit.author.name
      end

      def file_top_author(blame, filename)
        authored_lines = Hash.new(0)
        blame.lines.each { |l| authored_lines[l.commit.author.name] += 1 }
        # @excluded_authors.each { |a| authored_lines.delete(a) }
        top_author = authored_lines.max_by { |a, numlines| numlines }.first
      end
    end
  end
end
