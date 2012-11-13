module Base
  class Generators
    class Counter1n < Core
      attr_reader :number_of_terms
      def initialize(variables, opts = {:radix => 3})
        @variables = variables
        @complete = opts[:complete]
        @output = []
        super(@variables.size, opts)
        @number_of_terms = radix**number_of_inputs
        @number_of_outputs = nil
      end

      def signature
        'counter_1_%s' % (radix - 1)
      end

      def number_of_outputs
        # Ni: number of inputs is the max number for each count of 1,2
        # Max(o) = Ni: Is max possible output for each counter
        # No: 2 (for 1 and 2) * Log_r(Ni): Log (base radix) of Max Output
        # Example:
        # base   |  Ni       |  Formula                   | No   |   Ni                       | 2's   1's
        #   3    |  5        |  Log_3(5).ceil * 2         |  4   |  22012                     | 10    01 (base 3)
        #   3    |  5        |  Log_3(5).ceil * 2         |  4   |  11111                     | 00    12 (base 3)
        #   4    |  20       |  Log_4(20).ceil * 2        |  6   |  02211223330223322122      | 022   003 (base 4)
        #   4    |  20       |  Log_4(20).ceil * 2        |  6   |  22222222222222222222      | 220   000 (base 4)
        #
        # Ni = 5
        # No = Log_3(5).ceil * 2 = 4
        @number_of_outputs ||= (radix-1) * (Math.log(number_of_inputs + 1) / Math.log(radix)).ceil
      end

      # generates input output specification for specified radix and number of variables
      def specification
        0.upto(number_of_terms-1).map do |i|
          term = to_radix(i)
          output =  "%0#{number_of_outputs}d" % count_of_digits(term).to_i

          "%s %s" % [term, output]
        end
      end

      private
      def count_of_digits(term)
        groups = term.split('').group_by(&:to_s)
        digit_counts = ""
        digits_per_literal = number_of_outputs / (radix - 1)
        (radix-1).downto(1).each do |index|
          digit_counts += to_radix((groups[index.to_s] || []).length, digits_per_literal)
        end
        digit_counts
      end
    end
  end
end
