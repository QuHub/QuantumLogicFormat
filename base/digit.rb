class Digit < String
  attr_accessor :radix, :value

  def initialize(value, *args)
    opts = args.extract_options!
    @radix = args[0] || 10
    @width = opts[:width] || value.to_s.length
    super("%0#{@width}d" % value.to_i)
  end

  def unshift(value)
    insert(0, value.to_s)
  end

  def push(value)
    insert(-1, value.to_s)
  end

  def ==(value)
    value.to_s == self
  end
end
