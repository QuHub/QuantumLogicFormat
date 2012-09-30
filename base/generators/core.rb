module Base
  class Generators
    class Core
      attr_accessor :number_of_inputs, :number_of_outputs, :radix
      def initialize(number_of_inputs, *args)
        opts = args.extract_options!
        @number_of_inputs = number_of_inputs
        @number_of_outputs = args[0] || @number_of_inputs
        @radix = opts[:radix] || 3
      end

      def to_radix(number, number_of_variables = number_of_inputs)
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

