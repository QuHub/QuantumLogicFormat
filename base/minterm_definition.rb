class MintermDefinition < OpenStruct
  def initialize(minterm_spec, default={})
    @minterm_spec = minterm_spec
    @default = default
    super minterm_spec
  end

  def radix_mask
    
  end
end
