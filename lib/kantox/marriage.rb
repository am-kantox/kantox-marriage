require 'kantox/marriage/version'
require 'kantox/marriage/subset_sum_dynamic'
require 'kantox/marriage/subset_sum_approx'

module Kantox
  module Marriage
    def go meth, a1, a2
      r = case meth
          when :matrix then SubsetSumMatrix.go(a1 + a2.map(&:-@))
          when :approx then SubsetSumApprox.go(a1 + a2.map(&:-@))
          else fail "Unknown method for «go»: #{meth}"
          end
      r.group_by { |e| e > 0 }.map { |k, v| k ? v : v.map(&:-@) }
    end
    module_function :go
  end
end
