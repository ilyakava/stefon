module Stefon
  # todo
  # this class represents extra information that the editor needs to know before writing a script for Stefon
  class Config
    attr_reader :authors_to_exclude, :weights

    def initialize(authors_to_exclude, weights)
      # in the future this will be provided arguments by the config loader
      # class after it loads them from yaml files
      self.authors_to_exclude = []
      weights = {
        deleted_line: 2,
        deleted_file: 4,
        added_line: 1,
        added_file: 1
      }
    end
  end
end
