# encoding: utf-8

require 'grit'

module Stefon
  module Surveyor
    # A class that abstracts dealing with the grit gem while
    # respecting/knowing some restrictions, namely excluding authors
    class GritUtil
      attr_reader :repo
      # The number of commits by the user (sui ~ self / origin).
      # This is important to take into account when the user makes multiple
      # commits when working on someone else's project, to ensure that diffs
      # do not include recent changes made by the user in her last few commits
      attr_reader :num_sui_commits
      # The last commit not made by the user (sui ~ self) but by another
      # person (xeno ~ not self / not origin).
      # This is important to take into account when the user makes multiple
      # commits when working on someone else's project, to ensure that diffs
      # do not include recent changes made by the user in her last few commits
      attr_reader :last_xenocommit

      include Config::ExcludedAuthors

      # sets num_sui_commits and last_xenocommit attributes, if the current
      # user is the only commiter in the repo, these are set to the most
      # recent commit, since in this case, stefon would always recommend
      # the current user anyway. In the future, an error may be raised here
      def initialize
        @repo = Grit::Repo.new('.')
        commits = @repo.commits(GitUtil::CURRENT_BRANCH)
        @num_sui_commits = commits.find_index do |commit|
          commit.author.name != @repo.config['user.name']
        end
        @num_sui_commits ||= 0
        @last_xeno_commit = commits[@num_sui_commits]
      end

      def blame_for(filename)
        @repo.blame(filename, @last_xeno_commit)
      end

      def valid_line_author(blame, line)
        matched_line = blame.lines.find { |l| l.line.strip == line }
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
