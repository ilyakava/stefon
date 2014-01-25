require 'grit'

module Stefon
  module Surveyor
    # A class that abstracts dealing with the grit gem while respecting/knowing some
    # restrictions, namely excluding authors
    class GritUtil
      attr_reader :repo, :num_sui_commits, :last_xenocommit

      include Config::ExcludedAuthors

      # About the attribute names
      # num_sui_commits is important when a user makes multiple commits when working on
      # someone else's project, to ensure that diffs do not include recent changes made by
      # the user, the number of commits by the user (sui ~ self / origin) should be taken into account
      # when calling a diff, so as to compare changes against the last commit not made
      # by the user (self), but by another person (xeno ~ not self / not origin)
      def initialize
        @repo = Grit::Repo.new(".")
        commits = @repo.commits(GitUtil::CURRENT_BRANCH)
        # If you are the only commiter _ever_,  then num_sui_commits would be irrelevant
        # perhaps an error should be raised? Since in this case only yourself would be recommended
        @num_sui_commits = commits.find_index { |c| c.author.name != @repo.config["user.name"] } || 0
        @last_xeno_commit = commits[@num_sui_commits]
      end

      def blame_for(filename)
        repo.blame(filename, @last_xenocommit)
      end

      def valid_line_author(blame, line)
        matched_line = blame.lines.detect { |l| l.line.strip == line }
        author = matched_line.commit.author.name if matched_line
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
