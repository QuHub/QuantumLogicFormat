module Base
  class Specification
    attr_accessor :configuration

    def initialize(configuration=nil)
      @configuration = configuration
    end

    def raw
      @specification ||= configuration.yaml['specification']
    end

    def parsed 
      to_base = lambda {|x| Digit.new(x, configuration.inputs.radix)}
      spec = raw.split("\n").map{|x| x.split(" ")}
      inputs = spec.map(&:first).map(&to_base)
      outputs = spec.map(&:last).map(&to_base)
      return [inputs, outputs] 
    end

    def self.template_file_name
      File.expand_path('../specification_template.qlf', __FILE__)
    end
    
    def self.template_file
      File.read template_file_name
    end

    def self.specification_class(function)
       ("Base::Generators::%s" % function.classify).constantize
     end
     
    def self.generate(function, radix, number_of_variables, options = {})
      number_of_variables = number_of_variables.to_i
      template = Liquid::Template.parse(template_file)
      
      variables = ('a'..'z').take(number_of_variables)
      options[:radix] = radix
      instance = specification_class(function).new(variables, options)

      d = template.render('function' => instance.signature, 
          'radix' => radix, 
          'number_of_inputs' => instance.number_of_inputs, 
          'number_of_outputs' => instance.number_of_outputs, 
          'specification' => instance.specification)
    end

    def self.convert(equations, options = {})
      function = 'equation_to_table'
      instance= specification_class(function).new(equations, options)
      number_of_variables = instance.number_of_inputs
      template = Liquid::Template.parse(template_file)
      
      input_order, output_order = instance.table_header.split(' ')
      d = template.render('function' => instance.signature, 
          'radix' => instance.radix, 
          'number_of_inputs' => instance.number_of_inputs, 
          'number_of_outputs' => instance.number_of_outputs, 
          'specification' => instance.specification,
          'input_order'  => input_order,
          'output_order' => output_order
          )
    end
  end
end
