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

  # This module holds custom behavior for dealing with the gem trollop
  module Options
    def self.get
      proc do
        version "stefon #{Stefon::VERSION} (c) 2014 Ilya Kavalerov"
        banner <<-EOS
          Stefon is a utilty that recommends who to ask for a code review.
          He lets you know whose code you are affecting the most.

          Usage:
                 stefon [options]
          where [options] are:
        EOS

        opt :limit, 'Limit the number of people that stephon suggests sending ' +
          'a code review to',
          default: 4, short: '-l'
        opt :full_report, "Boolean for whether or not to include information " +
          "about how you affected someone's code",
          default: false, short: '-f'
      end
    end
  end
end
