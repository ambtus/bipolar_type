class Realm < Single

  NAME = %w{physical mental spiritual financial} # must all start with different letters

  ########
  ACRONYMS = NAME.map(&:first)
  ALL = ACRONYMS.collect {|letter| self.new letter}
  ACRONYMS.each {|letter| define_singleton_method(letter) { ALL[ACRONYMS.index(letter)] } }
  ########

  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  def +(nature); subtypes.find{|s| s.nature == nature} || Subtype.new([self, nature]); end

  def generic; choose Adjective, NAME; end
  def adverb; generic.ly; end
  def name; Phrase.new [generic.capitalize, symbol.parenthesize]; end

  def color; choose Adjective, %w{red green blue gold}; end # Arbitrary

  def energy; choose Noun, %w{caloric factual emotional monetary}; end

  def consume; choose Verb, %w{eat watch listen earn}; end
  def consumer; consume.er; end
  def get; choose Verb, %w{eat see hear earn}; end
  def resource; choose Verb, %w{food truth voice reward}; end
  def resources; resource.pluralize; end
  def consumption; Phrase.new [get, resources]; end
  def empty; choose Adjective, %w{hungry unsure lonely broke}; end
  def energizers; choose Noun, %w{carbs colors music cash}; end
  def potential; choose Noun, %w{fat memories values savings}; end
  def empty; choose Noun, %w{hungry unsure lonely poor}; end
  def overwhelmed; choose Noun, %w{sick afraid suicidal angry}; end

  def produce; choose Verb, %w{move think communicate buy}; end
  def producer; produce.er; end
  def achieve; choose Verb, %w{do predict express spend}; end
  def goals; choose Verb, %w{things results opinions rewards}; end
  def production; Phrase.new [achieve, goals]; end
  def strength; choose Noun, %w{muscle rules vocabulary debt}; end
  def worn; choose Adjective, %w{sore stupid misunderstood indebted}; end
  def strengtheners; choose Noun, %w{protein shapes stories credit}; end
  def fast; choose Verb, %w{run guess talk shop}; end
  def strong; choose Verb, %w{lift decide write borrow}; end

end
