class State < Concept

  STATES = %w{obesity depression mania anorexia}

  ########
  ACRONYMS = STATES.map(&:first)
  ALL = ACRONYMS.collect {|letter| self.new letter}
  ACRONYMS.each do |letter|
    define_singleton_method(letter) {ALL[ACRONYMS.index(letter)]}
  end
  ########

  def subtypes; Subtype.all.select{|s| s.state == self}; end
  def +(energy); subtypes.find{|s| s.energy == energy}; end

  def state; STATES[index]; end
  def name; state.titleize; end
  def symbol; path.upcase; end

end
