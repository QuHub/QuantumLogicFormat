require 'ostruct'
require 'yaml'
require 'active_model'

module Base
  class Configuration
    include ActiveModel::AttributeMethods
    include ActiveModel::Conversion
    include ActiveModel::Naming

    attr_accessor :default, :inputs, :outputs, :specification, :filename

    def initialize(filename=nil, yaml = nil)
      @filename = filename if filename
      @yaml = YAML.load(yaml) if yaml
      parse
    end

    def parse
      raise 'must specify specification filename' unless filename || @yaml
      @default = OpenStruct.new(yaml['defaults'])
      @inputs = MintermDefinition.new(yaml['inputs'], yaml['defaults'])
      @outputs = MintermDefinition.new(yaml['outputs'], yaml['defaults'])
      @specification = Specification.new(self)
    end

    def yaml
      @yaml ||= YAML.load_file(filename)
    end
  end
end

