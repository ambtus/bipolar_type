class Attitude < Indexable

  ########
  LETTERS = %w{EP EJ IP IJ}
  ALL = LETTERS.collect{|letter| self.new letter}
  all.each { |a| define_singleton_method(a.path) {all[LETTERS.index a.string]} }
  ########

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end
  def generic_subtype; Subtype.new [Realm.generic, self]; end

  def energetic?; index < 2; end
  def strong?; index.odd? ; end

  def energetic_verb_prefix; choose Word, %w{NIL both neither do\ not}; end
  def strong_verb_prefix; choose Word, %w{but\ do\ not and nor  but\ I\ do}; end

  def energetic_adjective_prefix; choose Word, %w{NIL both neither not}; end
  def strong_adjective_prefix; choose Word, %w{but\ not and nor  but\ I\ am}; end

  def energetic_noun_prefix; choose Word, %w{have have\ both have\ neither do\ not\ have}; end
  def strong_noun_prefix; choose Word, %w{but\ do\ not\ have and\ I\ have nor\ do\ I\ have  but\ I\ do\ have}; end

  def generic; choose Adjective, %w{energetic active inactive strong}; end

  def name; Phrase.new [generic.titleize, parenthesize]; end
end
