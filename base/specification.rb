module Base
  class Specification
    attr_accessor :configuration
    CompletionWildCard = ['*', '*']
    def initialize(configuration)
      @specification = configuration.yaml['specification']
    end

    def raw
      @specification
    end

    def parsed 
      spec = raw.split("\n").map{|x| x.split(" ")}
      inputs = spec.map(&:first).map(&:to_i)
      outputs = spec.map(&:last).map(&:to_i)
      return [inputs, outputs] 
    end

    def self.template_file_name
      File.expand_path('../specification_template.qlf', __FILE__)
    end
    
    def self.template_file
      File.read template_file_name
    end

    def self.specfication_class(function)
       ("Base::Generators::%s" % function.titleize).constantize
     end
     
    def self.generate(function, radix, number_of_variables)
      template = Liquid::Template.parse(template_file)
      
      variables = ('a'..'z').take(number_of_variables)
      specification = specfication_class(function).new(variables, :radix => radix).specification
      template.render('function' => function, 'radix' => radix, 'number_of_variables' => number_of_variables, 'specification' => specification)
    end
  end
end
