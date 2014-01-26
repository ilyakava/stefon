# encoding: utf-8

module Stefon
  # This class is responsible for handling the command line interface
  class CLI
    # The entry point for the application logic
    def run(opts)
      options = opts.merge(Config::Weights.get)
      editor = Stefon::Editor.new(options)
      editor.summarize_results
    end
  end
end