class Attitude < Indexable

  ########
  LETTERS = %w{ EP EJ  IP IJ  }
  ALL = LETTERS.collect{|letter| self.new letter}
  all.each { |a| define_singleton_method(a.path) {all[LETTERS.index a.string]} }
  ########

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end
  def generic_subtype; Subtype.new [Realm.generic, self]; end

  def domain; choose Noun, %w{ fat strong  weak thin  }; end
  def name; Phrase.new [domain.titleize, parenthesize]; end

  def energetic?; index < 2; end
  def strong?; index.odd?; end
  def balanced?; [1,2].include? index; end

  def wannabee; Attitude.all.values_at(2, 0, 3, 1)[index]; end
  def goal; Attitude.all.values_at(1, 1, 2, 2)[index]; end


end
