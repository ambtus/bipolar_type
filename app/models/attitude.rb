class Attitude < Indexable

  LETTERS = %w{a b c d}
  ALL = LETTERS.collect{|letter| self.new letter}

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end

  def domain; choose Adjective, %w{energy energetic strong strength}; end
  def name; domain.titleize; end

  AFFECTS = %w{wonderful good bad horrible}
  def manic_affect; Adjective.new AFFECTS[index]; end
  def depressed_affect; Adjective.new AFFECTS.reverse[index]; end

  def sensitivity_adjective; choose Adjective, %w{most relatively relatively most}; end
  def sensitivity_noun; choose Noun, %w{insensitive insensitive sensitive sensitive}; end
  def sensitivity; Phrase.new [sensitivity_adjective, sensitivity_noun]; end

end
