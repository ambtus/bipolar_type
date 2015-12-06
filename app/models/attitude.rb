class Attitude < Indexable

  LETTERS = %w{a b c d}
  ALL = LETTERS.collect{|letter| self.new letter}

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end

  def domain_adjective; choose Adjective, %w{insensitive insensitive sensitive sensitive}; end
  def domain_noun; choose Adjective, %w{consumer producer consumer producer}; end
  def domain; Phrase.new [domain_adjective, domain_noun]; end
  def name; domain.titleize; end

  def manic_affect; choose Adjective, %w{wonderful good horrible bad}; end
  def depressed_affect; choose Adjective, %w{bad horrible  wonderful good }; end

end
