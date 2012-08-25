module Base
  class Generators
    class Core
      attr_accessor :number_of_variables, :radix
      def initialize(number_of_variables, opts)
        @number_of_variables = number_of_variables
        @radix = opts[:radix]
      end

      def to_radix(number)
        result = '' 
        0.upto(number_of_variables-1).each do |i|
          result += (number % radix).to_s
          number /= radix
        end
        result.reverse
      end
    end
  end
end

