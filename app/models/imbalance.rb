class Imbalance < Concept

  NOUNS = %w{addiction paralysis aversion compulsion }

  ########
  ACRONYMS = %w{a p v c}
  ALL = ACRONYMS.collect {|letter| self.new letter}
  ACRONYMS.each do |letter|
    define_singleton_method(letter) {ALL[ACRONYMS.index(letter)]}
  end
  ########

  def subtypes; Subtype.all.select{|s| s.imbalance == self}; end
  def +(energy); subtypes.find{|s| s.energy == energy}; end

  def noun; NOUNS[index]; end
  def name; noun.titleize; end
  def symbol; path.upcase; end

end
