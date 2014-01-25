require 'rake'
require 'rake/tasklib'


module Stefon
  # Provides a custom rake task.
  #
  # require 'stefon/rake_task'
  # Stefon::RakeTask.new
  class RakeTask < Rake::TaskLib
    attr_accessor :name
    attr_accessor :verbose
    attr_accessor :fail_on_error
    attr_accessor :patterns
    attr_accessor :formatters

    def initialize
      desc 'Run Stefon'

      RakeFileUtils.send(:verbose, verbose) do
        run_task(verbose)
      end
    end

    def run_task(verbose)
      require 'stefon'

      cli = CLI.new
      puts 'Running Stefon...' if verbose
      result = cli.run
      puts result
      # abort('Stefon failed!') if fail_on_error
    end
  end
end
