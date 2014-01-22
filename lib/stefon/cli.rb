module Stefon
  # This class is responsible for handling the command line interface
  class CLI
    def initialize
      @config = ConfigLoader.run
    end
    # The entry point for the application logic
    def run
      editor = Editor.new
      editor.summarize_results(@config)
    end
  end
end