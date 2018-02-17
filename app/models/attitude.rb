class Attitude < Concept

# first row  : a→ b↓
# second row : ↑d ←c

  ########
  ACRONYMS = %w{a b d c}
  ALL = ACRONYMS.collect {|letter| self.new letter}
  ACRONYMS.each do |letter|
    define_singleton_method(letter) {ALL[ACRONYMS.index(letter)]}
  end
  ########

  def self.linear; ALL.values_at(0,1,3,2); end  # a b c d

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end
  def +(realm); subtypes.find{|s| s.realm == realm}; end

  ARROWS = %w{→ ↓ ↑ ←}
  def arrow; ARROWS[index]; end

end
