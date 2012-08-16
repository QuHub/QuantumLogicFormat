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
  end
end
