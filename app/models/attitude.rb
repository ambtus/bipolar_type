class Attitude < Indexable

  LETTERS = %w{a b c d}
  ALL = LETTERS.collect{|letter| self.new letter}

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end

  def domain; choose Adjective, %w{top high low bottom}; end
  def name; domain.titleize; end

  AFFECTS = %w{wonderful bad good horrible}
  def manic_affect; Adjective.new AFFECTS[index]; end
  def depressed_affect; Adjective.new AFFECTS.reverse[index]; end

end
