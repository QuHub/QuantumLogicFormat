module Base
  class Generators
    class NumberGteConstant < Core
      attr_reader :number_of_terms, :constant
      def initialize(variables, opts)
        @variables = variables
        @constant = opts[:constant]
        raise 'Must specify constant' unless constant

        @complete = opts[:complete]
        @output = []
        super(@variables.size, opts)
        @number_of_terms = radix**number_of_inputs
        @number_of_outputs = 1
      end

      def signature
        '%s-%sgte%s' % [radix, number_of_inputs, constant]
      end

      # generates input output specification for specified radix and number of variables
      def specification
        0.upto(number_of_terms-1).map do |i|
          term = to_radix(i) 
          truth =  i >= constant ? 1 : 0
          output =  "%0#{number_of_outputs}d" % truth

          "%s %s" % [term, output]
        end
      end
    end

    class NumberGte10 < NumberGteConstant
      def constant; 10; end
    end

    class NumberGte11 < NumberGteConstant
      def constant; 11; end
    end

    class NumberGte12 < NumberGteConstant
      def constant; 12; end
    end
  end
end
