# encoding: utf-8

module Stefon
  # this class represents extra information that the editor needs to know before writing a script for Stefon
  module Config
    # This module is responsible for ruling out/in authors for the repository
    # based on user specification, or repo members on github
    module ExcludedAuthors
      def valid?(author)
        # exclude_filter(author) && include_filter(author)
        true
      end
    end

    # This module is in charge of providing weights to rank certain kind of edits over
    # others, Eg. Deleting Stephanie's line of code is more important than adding
    # a line of code to Stephanie's file
    module Weights
      attr_reader :default
      attr_accessor :custom

      def self.get(custom = nil)
        # in the future this will be provided arguments by the config loader
        # class after it loads them from yaml files
        @default = {
          deleted_line: 2,
          deleted_file: 4,
          added_line: 1,
          added_file: 1
        }
        @default unless custom
      end
    end
  end
end
