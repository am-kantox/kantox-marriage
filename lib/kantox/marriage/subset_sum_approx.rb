module Kantox
  module Marriage
    class SubsetSumApprox
      class << self
        def go array, reference_value = 0
          SubsetSumApprox.new(array).subset(reference_value)
        end
      end

      def initialize array
        @subset = {}
        @array = array
        @gamma = 2 ** (- @array.max.to_s(2).length)
      end

      def subset reference_value = 0
        @subset[reference_value] ||= approx_subset_sum reference_value, @gamma
      end

      def to_s
        "#{@array} ⇒ #{subset}"
      end

    private
      def approx_subset_sum value, gamma
        subsets = { 0 => [] }
        @array.each_with_index do |elem, i|
          old_subsets = subsets
          subsets = {}
          #add current element to the sum of previously included subsets
          old_subsets.each do |prev_sum, subset|
            # the following three lines generate the news sums and the associated subsets
            subsets[prev_sum] = subset
            new_sum = prev_sum + elem
            new_subset = subset.dup << elem
            # if the newly computed sum happens to equal the objective value we return the subset sum pair
            if new_sum == value
              return new_subset
            else # we create a new entry for the computed sum or overwrite and existing one
              subsets[new_sum] = new_subset
            end
          end
          # we trim the new list of sums and subsets generated by the inclusion of the element given approx parameter gamma
          subsets = trim(subsets, gamma / (2.0**i))
        end

        (result = subsets.reject { |_, arr| arr.reduce(&:+) != value }.sort.last) ? result.last : []
      end

      # set is hash where the keys are the sums of the subsets which are the values
      def trim hash, gamma
        arr = hash.sort
        Hash[arr.inject([arr.shift]) do |memo, curr_sum|
          memo << curr_sum unless curr_sum.first / (1 + gamma) <= memo.to_a.last.first
          memo
        end]
      end
    end
  end
end