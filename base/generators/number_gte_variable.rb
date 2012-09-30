module Base
  class Generators
    class NumberGteVariable < Core
      attr_reader :number_of_terms, :number
      def initialize(variables, opts)
        @variables = variables
        @target = opts[:target]
        raise 'Must specify number of target digits' unless @target
        raise 'Base size cannot be greater than target size' if @target > @variables.size

        @complete = opts[:complete]
        @output = []
        super(@variables.size, opts)
        @number_of_outputs = 1
      end

      def signature
        '%s-%sgtev%s' % [radix, number_of_inputs, @target]
      end

      # generates input output specification for specified radix and number of variables
      def specification
        0.upto(radix ** @target - 1).each do |target|
          0.upto(radix ** number_of_inputs - 1).map do |i|
            term = "%s%s" % [to_radix(i), to_radix(target, @target)]
            truth =  i >= target ? 1 : 0
            @output << "%s %s" % [term, truth]
          end
        end
        @output
      end
    end
  end
end
