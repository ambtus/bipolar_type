class Energy < Concept

  ENERGIES = %w{physical mental financial social}

  ########
  ACRONYMS = ENERGIES.map(&:first)
  ALL = ACRONYMS.collect {|letter| self.new letter}
  ACRONYMS.each do |letter|
    define_singleton_method(letter) {ALL[ACRONYMS.index(letter)]}
  end
  ########

  def subtypes; Subtype.all.select{|s| s.energy == self}; end
  def +(state); subtypes.find{|s| s.state == state}; end

  def energy; ENERGIES[index]; end
  def name; energy.capitalize; end
  def symbol; path.upcase; end

end
