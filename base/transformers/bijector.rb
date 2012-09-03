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
        outputs = expand_outputs(outputs)
        outputs = complete_outputs(inputs, outputs)
      end


      def hamming

      end

      private
      def complete_outputs(inputs, outputs)
#hd = hamming_distance(inputs, outputs)
       
        # Sort by min hamming distance.
        # Allocate bits by min hamming distance.
        # 
        
      end

      def terms_for(number_of_variables, radix)
        number_of_terms = radix**number_of_variables
        number_of_terms.times.map do |index|
        Digit.new(index.to_s(radix), :width => number_of_variables)
        end
      end

      def hamming_distance(inputs, outputs)
        outputs = to_vectors(outputs)
        width = inputs.size
        hd = []
        to_vectors(inputs).each do |inp|
          x = [].tap do |hamming| 
            outputs.each do |out|
              hamming << [inp, out].transpose.map{|a,b| a==b ? 0 : 1 }
            end
          end
          hd << (0..width-1).zip(x.map{|x| x.reduce(:+)})
        end
        hd
      end

      def to_vectors(list)
        list.map {|x| x.reverse.split(//).map(&:to_i)}.transpose
      end

      def expand_inputs(inputs)
        variables_to_complete_inputs.times do 
          size = inputs.size
          inputs += inputs.map{|x| x.clone }
          inputs[0..size-1].map{|x| x.unshift(0)}
          inputs[size..-1].map{|x| x.unshift(1)}
        end

        inputs
      end

      def expand_outputs(outputs)
        variables_to_complete_inputs.times do 
          outputs += outputs.map{|x| x.clone }
        end

        outputs
      end

      def grouped_outputs
        specification.parsed.last.group_by(&:to_s)
      end

      def variables_to_complete_input
        @variables_to_complete_input ||= total_variables - configuration.inputs.variables
      end

      def total_variables
        @total_variables ||= variables_to_complete_output + configuration.outputs.variables
      end

      def total_terms
        @total_terms ||= radix**total_variables
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
