module Xirr

  #  Base module for XIRR calculation Methods
  module Base
    extend ActiveSupport::Concern
    attr_reader :cf

    # @param cf [Cashflow]
    # Must provide the calling Cashflow in order to calculate
    def initialize(cf)
      @cf = cf
    end

    # Net Present Value function that will be used to reduce the cashflow
    # @param rate [BigDecimal]
    # @return [BigDecimal]
    def xnpv(rate)
      cf.inject(0) do |sum, t|
        periods_from_start = (t.date - cf.min_date) / cf.period
        sum += t.amount / ((1 + rate)**periods_from_start)
      end
    end
  end
end
