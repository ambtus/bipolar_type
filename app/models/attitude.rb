class Attitude < Indexable

  LETTERS = %w{a b c d}
  ALL = LETTERS.collect{|letter| self.new letter}
  all.each { |r| define_singleton_method(r.path) {all[LETTERS.index r.string]} }

  def ordinal; %w{first second third fourth}[index]; end

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end

  def suffix; %w{e e i i}[index]; end

  def adjective; choose Adjective, %w{fat bulimic thin skinny}; end
  #def name; Phrase.new [adjective.capitalize, parenthesize]; end
  def name; adjective.capitalize; end

  def sensitivity_amount; choose Adjective, %w{least less more most}; end
  def sensitivity; Phrase.new [sensitivity_amount, "sensitive"]; end
  def manic; choose Adjective, %w{bulimic thin skinny anorexic}; end
  def depressed; choose Adjective, %w{obese fat bulimic thin}; end

end
