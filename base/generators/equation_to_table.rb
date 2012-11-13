module Base
  class Generators
    class EquationToTable < Core
      attr_accessor :equations
      def initialize(equations, opts = {})
        @radix = opts[:radix] = 2  # only handle binary case for the moment.
        self.equations = equations.map{|x| x.split("=").map(&:strip)}
        @inputs = opts[:order].split('') if opts[:order]
        @number_of_inputs = inputs.length
        @number_of_outputs = outputs.length
      end

      def signature
        'equation_to_table_%s' % (@radix - 1)
      end

      def inputs
        @inputs ||= begin
          equations.map do |_,eq|
            eq.gsub(/[^a-zA-Z0-9]/, ' ').split(' ')
          end
        end.flatten.uniq.sort
      end

      def outputs
        @outputs ||= begin
          equations.map(&:first).uniq.sort 
        end
      end

      def specification
        to_table         
      end

      def table_header
        "%s %s" % [inputs * '', outputs * '']
      end

      def to_table
        terms = equations.map do |eq|
          evaluate_equation(eq.last)
        end

        terms = terms.transpose.map(&:join)

        table = []
        0.upto(2 ** number_of_inputs- 1).map do |index|
          table << ("%0#{number_of_inputs}d %s" % [index.to_s(2).to_i, terms[index]])
        end
        table
      end

      def evaluate_equation(eq)
        0.upto(2 ** number_of_inputs - 1).map do |index|
          assign(index)
          # bitwise AND the result with 1 to remove the 2's complement resulting from NOT terms in the equation
          eval("%s & 1" % eq.gsub(/([a-zAZ])/, '@\1')).to_s  
        end
      end

      # %w(a b c d ...)
      def assign(term)
        number_of_inputs.times do 
          instance_variable_set("@#{inputs.last}", term & 1)
          inputs.rotate!(-1)
          term >>= 1
        end
      end
    end
  end
end

