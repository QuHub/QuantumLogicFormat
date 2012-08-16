require 'ostruct'
require 'yaml'
require 'active_model'

module Base
  class Configuration
    include ActiveModel::AttributeMethods
    include ActiveModel::Conversion
    include ActiveModel::Naming

    attr_accessor :default, :inputs, :outputs, :specification

    def initialize(filename=nil)
      @filename = filename
      parse
    end

    def parse
      raise 'must specify specification filename' unless filename
      @default = OpenStruct.new(yaml['defaults'])
      @inputs = MintermDefinition.new(yaml['inputs'], yaml['defaults'])
      @outputs = MintermDefinition.new(yaml['outputs'], yaml['defaults'])
      @specification = Specification.new(self)
    end

    def filename
      @filename
    end

    def yaml
      @yaml ||= YAML.load_file(filename)
    end
  end
end

