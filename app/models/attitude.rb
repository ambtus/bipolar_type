class Attitude < Indexable

  ########
  LETTERS = %w{P E I J}
  ALL = LETTERS.collect{|letter| self.new letter}
  def path; super.downcase; end
  def self.paths; all.map(&:path); end
  all.each do |realm|
    define_singleton_method(realm.path) {all[LETTERS.index realm.string]}
  end
  4.times {|i| define_singleton_method(i.next.word) {all[i]}}
  ########

  def partial; index.next.word; end

  def subtype_words(realm); %w{P J}.include?(letter) ? [realm, self] : [self, realm]; end
  def subtypes; Subtype.all.select{|s| s.attitude == self}; end

  def domain; choose Adjective, %w{fat strong steady thin}; end
  def name; Phrase.new [domain.titleize, parenthesize]; end

  def gain_ease(realm); choose Adjective, %w{easy easy hard hard}; end
  def gain_potentials(realm)
    Phrase.new ["it’s", gain_ease(realm), "for me to gain new", realm.potentials]
  end

  def lose_ease(realm); choose Adjective, %w{hard easy hard easy}; end
  def lose_potentials(realm)
    Phrase.new ["it’s", lose_ease(realm), "for me to get rid of old", realm.potentials]
  end

  def and_but; choose Word, %w{but and and but}; end

  def short(realm)
    Phrase.new [gain_potentials(realm).capitalize, and_but, lose_potentials(realm).period]
  end

end
