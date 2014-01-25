module Stefon
  module Surveyor
    # A class that abstracts dealing with the grit gem while respecting/knowing some
    # restrictions, namely excluding authors
    class GritUtil
      attr_reader :repo

      include Config::ExcludedAuthors

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

      def valid_line_author(blame, line)
        matched_line = blame.lines.detect { |l| l.line.strip == line }
        author = matched_line.commit.author.name
        author if valid?(author)
      end

      def file_valid_top_author(blame, filename)
        authored_lines = Hash.new(0)
        blame.lines.each do |l|
          author = l.commit.author.name
          authored_lines[author] += 1 if valid?(author)
        end
        top_author_line_pair = authored_lines.max_by { |a, numlines| numlines }
        top_author_line_pair.first if top_author_line_pair
      end
    end
  end
end
