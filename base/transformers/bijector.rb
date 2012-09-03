module Base
  class Transformers
    class Bijector
      attr_accessor :specification, :configuration
      def initialize(specification)
        @specification = specification 
        @configuration = specification.configuration
      end

      def complete
        # add additional terms to statisfy the number of variables of
        # the completed (expanded) input vector
        inputs, outputs = specification.parsed

        inputs = expand_inputs(inputs)

      end


      def hamming

      end

      private
      def expand_inputs(inputs)
        variables_to_complete_inputs.times do 
          size = inputs.size
          inputs += inputs.map{|x| x.clone }
          inputs[0..size-1].map{|x| x.unshift(0)}
          inputs[size..-1].map{|x| x.unshift(1)}
        end

        inputs
      end

      def complete_inputs
        inputs = specification.parsed.first
        variables_to_complete_inputs.times {inputs += inputs}
      end

      def complete_outputs
      end

      def grouped_outputs
        specification.parsed.last.group_by(&:to_s)
      end

      def variables_to_complete_input
        @variables_to_complete_input ||= variables_to_complete_output - configuration.inputs.variables
      end

      def variables_to_complete_output 
        @variables_to_complete_output ||= begin  
          max_count = grouped_outputs.values.map(&:count).max
          (Math.log(max_count) / Math.log(configuration.outputs.radix)).ceil
        end
      end

    end
  end
end
