class Attitude < Indexable

  ########
  LETTERS = %w{E P J I}
  ALL = LETTERS.collect{|letter| self.new letter}
  def path; super.downcase; end
  def self.paths; all.map(&:path); end
  all.each do |realm|
    define_singleton_method(realm.path) {all[LETTERS.index realm.string]}
  end
  4.times {|i| define_singleton_method(i.next.word) {all[i]}}
  ########

  def subtype_words(realm); %w{P J}.include?(letter) ? [realm, self] : [self, realm]; end
  def subtypes; Subtype.all.select{|s| s.attitude == self}; end

 def behavior; choose Adjective, %w{splurge binge putz graze}; end
  def domain; choose Adjective, %w{strong fat thin weak}; end
  def name; Phrase.new [domain.titleize, parenthesize]; end

  def gain_ease; choose Adjective, %w{easy easy hard hard}; end
  def gain_potentials(realm)
    Phrase.new ["it’s", gain_ease, "for me to gain", realm.potentials]
  end

  def lose_ease; choose Adjective, %w{easier hard easy harder}; end
  def lose_potentials(realm)
    Phrase.new ["it’s", lose_ease, "for me to lose", realm.potentials]
  end

  def short(realm)
    Phrase.new [gain_potentials(realm).capitalize, "but", lose_potentials(realm).period]
  end

end
