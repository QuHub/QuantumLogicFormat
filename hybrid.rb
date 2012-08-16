# Finds the various functions based on the different variations of gates
#
class Combinations
  def self.c(n,r,&proc)
    if (n>0 && r>0)
      combine([], 0, n, r, proc)
    end
  end

  def self.get(n,r)
    combinations = []
    Combinations.c(n,r) {|c| combinations << c}
    combinations
  end

  private
  def self.combine(combination, s, n, r, proc)
    if (r == 0)
      proc.call(combination)
    else
      (s..(n-r)).each {|i| combine(combination + [i], i+1, n, r-1, proc)}
    end
  end
end


class Gate
  attr_accessor :proc, :name
  def initialize(proc, name)
    @proc, @name = proc, name
  end
end

gates = [
  Gate.new(lambda {|k| k }, "I"),
  Gate.new(lambda {|k| (k + 2) % 3 }, "+2"),
  Gate.new(lambda {|k| (k + 1) % 3 }, "+1"),
  Gate.new(lambda {|k| (2*k +2) % 3 }, "02"),
  Gate.new(lambda {|k| 2*k  % 3 }, "12"),
  Gate.new(lambda {|k| (2*k + 1) % 3 }, "01")
]

gates = gates + gates + gates

def run(d, gate1, gate2, gate3)
  (0..7).map do |i|
    g1 = gate1.proc.((i >> 2) & 1)
    g2 = gate2.proc.((i >> 1) & 1) if g1 == 2
    g3 = gate3.proc.(i  & 1) if g2 == 2
    g3 == 2 ? (d+1) & 1 : d
  end
end

x = []
p "a   b   c   d"
Combinations.get(18,3).uniq.each do |i, j, k|
  gate1 = gates[i]
  gate2 = gates[j]
  gate3 = gates[k]

  (0..1).each do |d|
    x << [ "%s,  %s,  %s, %d :" % [gate1.name, gate2.name, gate3.name, d], run(d, gate1, gate2, gate3)]
  end
end

x.uniq.group_by(&:last).each do |k, v|
  p k
  v.each {|f,l| p f}
end
