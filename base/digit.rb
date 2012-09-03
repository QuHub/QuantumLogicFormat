class Digit < String
  attr_accessor :radix, :value

  def initialize(value, radix = 10)
    @radix = radix
    super(value.to_s)
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
