module Base
  class Generators
    class Reflection < Core
      attr_reader :number_of_terms
      def initialize(variables, opts = {:radix => 3})
        @variables = variables
        @output = []
        super(@variables.size, opts)
        @number_of_terms = radix**number_of_variables
      end

      def generate
        feyman_ladder(@count) 
      end


      def feynman_ladder(count)
        0.upto(count-1).each do |i|
          @output << "t2 %s %s" % [variables[i], variables[i+1]]
        end
      end

      # generates input output specification for specified radix and number of variables
      def specification
        0.upto(number_of_terms-1).map do |i|
          term = to_radix(i) 
          "%s %s" % [term, term.reverse]
        end
      end
    end
  end
end
