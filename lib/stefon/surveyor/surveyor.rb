# encoding: utf-8

module Stefon
  module Surveyor
    # A store for the scores that each surveyor calculates, it takes
    # the form of a hash where author names are keys, and points are
    # values. Points are counts of lines or commits that belong to a person
    class SurveyorStore < ::Hash
      def initialize
        super(0)
      end

      def merge_scores(scores_hash)
        dup = self.dup
        scores_hash.each_pair do |name, score|
          dup[name] += score
        end
        dup
      end
    end

    # A scaffold for concrete surveyors, meant to be extended
    # This class calculates whose code the gem user is affecting
    # the most for a particular kind of behavior (eg. line / file deletion)
    class Base
      attr_accessor :scores

      def initialize
        @@grit ||= GritUtil.new
        self.scores = SurveyorStore.new
      end
    end
  end
end
