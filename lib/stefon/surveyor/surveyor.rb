module Stefon
  module Surveyor
    # A store for the scores that each surveyor calculates, it takes
    # the form of a hash where author names are keys, and points are
    # values. Points are counts of lines or commits that belong to a person
    class SurveyorStore < ::Hash
      def initialize
        super(0)
      end

      def merge_scores(*score_hashes)
        dup = self.dup
        score_hashes.each do |scores_hash|
          scores_hash.each_pair do |name, score|
            dup[name] += score
          end
        end
      end
    end

    # A scaffold for concrete surveyors, meant to be extended
    # This class calculates whose code the gem user is affecting
    # the most for a particular kind of behavior (eg. line / file deletion)
    class Surveyor
      attr_accessor :scores

      def initialize
        @@grit = GritUtil.new
        self.scores = SurveyorStore.new
      end
    end
  end
end
