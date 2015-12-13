class Attitude < Indexable

  LETTERS = %w{a b c d}
  ALL = LETTERS.collect{|letter| self.new letter}
  all.each { |r| define_singleton_method(r.path) {all[LETTERS.index r.string]} }

  def ordinal; %w{first second third fourth}[index]; end

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end

  STATES = %w{obese fat normal thin skinny anorexic}.collect{|s| Adjective.new(s) }
  def depressed; STATES[index + 2]; end
  def euthymic; STATES[index + 1]; end
  def manic; STATES[index + 0]; end

  def adjective; choose Adjective, %w{top dom sub bottom}; end
  #def name; Phrase.new [adjective.capitalize, parenthesize]; end
  def name; adjective.capitalize; end

  def sensitivity_amount; choose Adjective, %w{less less more more}; end
  def sensitivity; Phrase.new [sensitivity_amount, "sensitive"]; end

end
