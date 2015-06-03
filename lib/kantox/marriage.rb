require 'kantox/marriage/version'
require 'kantox/marriage/subset_sum_dynamic'

module Kantox
  module Marriage
    def go a1, a2
      r = SubsetSumMatrix.go(a1 | a2.map(&:-@))
      r.group_by { |e| e > 0 }.map { |k, v| k ? v : v.map(&:-@) }
    end
    module_function :go
  end
end
