module Kantox
  module Marriage
    class SubsetSumMatrix
      class << self
        def empty_matrix arr
          header =  Range.new(*arr.reduce([0, 0]) do |memo, e|
                      case e
                      when -Float::INFINITY..0 then memo[0] += e
                      when 0..Float::INFINITY  then memo[1] += e
                      end
                      memo
                    end).to_a

          [
            header.map.with_index do |h, i|
              [h, i + 1]
            end.compact.to_h,

            [
              [nil] + header,                      # head row
              *(0...arr.length).map do |i|         # values
                [i, ['F'] * header.length].flatten
              end
            ]
          ]
        end
        protected :empty_matrix

        def go array, reference_value = 0
          SubsetSumMatrix.new(array).subset(reference_value)
        end
      end

      def initialize array
        @subset = {}
        @column_value_to_index, @matrix = SubsetSumMatrix.send(:empty_matrix, @array = array)
      end

      def subset reference_value = 0
        @subset[reference_value.to_s] ||= initialize_first_row.populate.derive_subset reference_value
      end

      def to_s
        "#{@array} ⇒ #{subset}"
      end

    protected
      def initialize_first_row
        (1...@matrix[1].length).each do |i|
          @matrix[1][i] = 'T' if @array[@matrix[1][0]] == @matrix[0][i] # the only sum we can have is the first number itself
        end
        self
      end

      def populate
        (2...@matrix.size).each do |row|
          (1...@matrix[row].length).each do |i|
            @matrix[row][i] = 'T' if @array[@matrix[row][0]] == @matrix[0][i] || @matrix[row - 1][i] == 'T' || current_sum_possible(row, i)
          end
        end
        self
      end

      def current_sum_possible(row, column)
        column_index = @column_value_to_index[@matrix[0][column] - @array[@matrix[row][0]]]
        @matrix[row - 1][column_index] == 'T' if column_index
      end

      def derive_subset(reference_value)
        subset = []
        column_index = @column_value_to_index[reference_value]
        (@matrix.size - 1).downto(1) do |row|
          if @matrix[row][column_index] == 'F'
            return subset
          elsif @matrix[row - 1][column_index] == 'T'
            next
          else
            subset.insert(0, @array[row - 1])
            column_index = @column_value_to_index[@matrix[0][column_index] - @array[row - 1]]
          end
        end
        subset
      end
    end
  end
end

=begin
def subset_sum_dynamic(array, target_value)
  matrix = SubsetSumMatrix.new(array)
  #matrix.to_s
  matrix.initialize_first_row
  #matrix.to_s
  matrix.populate
  #matrix.to_s
  subset = matrix.derive_subset_for(target_value)
  puts "Subset sums to: #{ subset.reduce(0){|accumulator, value| accumulator + value} }"
  subset
end

def n_integers_randomized_between(range, n)
  range.to_a.shuffle[0...n]
end

#puts subset_sum_dynamic([1, -3, 4, 5, -8, 7, -1], 0).inspect
#puts subset_sum_dynamic([1, -3, 2, 4], 0).inspect
#puts subset_sum_dynamic([ 802, 421, 143, -302, 137, 316, 150, -611, -466, -42, -195, -295 ], 0).inspect
puts subset_sum_dynamic(n_integers_randomized_between((-1000..1000), 50), 0).inspect

if ENV["attest"]
  this_tests "generating subset sums using dynamic programming" do
    test("subset should be [1,-3,2]") do
      actual_subset_sum = subset_sum_dynamic([1, -3, 2, 4], 0)
      should_equal([1,-3,2], actual_subset_sum)
    end
    test("subset should be [1,-8, 7]") do
      actual_subset_sum = subset_sum_dynamic([1, -3, 4, 5, -8, 7, -1], 0)
      should_equal([1,-8,7], actual_subset_sum)
    end
    test("subset should be [316, 150,-466]") do
      actual_subset_sum = subset_sum_dynamic([ 802, 421, 143, -302, 137, 316, 150, -611, -466, -42, -195, -295 ], 0)
      should_equal([316,150,-466], actual_subset_sum)
    end
  end
end
=end
