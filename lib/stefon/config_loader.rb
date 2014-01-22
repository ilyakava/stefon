module Stefon
  # todo
  # This class loads the weights to be used by the Editor class and the
  # users to exclude in the score calculation (either from loading from a yml
  # file or from checking github)
  class ConfigLoader
    def self.run
      # in the future it will make an instance of the Config class
      # for both the default and user specified config, both of which will be
      # read from yaml
      Config.new
    end
  end
end
