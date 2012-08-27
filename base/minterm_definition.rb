class MintermDefinition < OpenStruct
  attr_accessor :default
  def initialize(minterm_spec, default={})
    @default = default
    super minterm_spec.merge(default)
  end

  def radix_mask
    case radix
      when Fixnum then (radix.to_s * variables).to_i
      when Hash then
        digits = radix.values.compact.uniq
        if !(default_radix = default['radix']) && digits.length != variables
          raise 'default radix must be specified in following format (radix: n)' 
        end


        mask = default['radix'].to_s * variables
        radix.each do |k,v|
          v.each {|i| mask[i] = k.to_s }
        end
        mask.reverse.to_i
      else raise ArgumentError, "Radix is not specified"
    end
  end
end
