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

  def domain_adjective; index.even? ? "extroverted" : "introverted"; end
  def domain_noun; index < 2 ? "extrovert" : "introvert"; end
  def domain; Phrase.new [domain_adjective, domain_noun]; end
  def name; Phrase.new [domain.titleize, parenthesize]; end

  def stressed?; index.between?(1,2); end
  def and_but; stressed? ? "but" : "and"; end
  def binge?; index < 2 ? "love to" : "hate to"; end
  def purge?; index.even? ? "do" : "do not"; end
  def short(realm)
    Phrase.new ["I", binge?, realm.binge, and_but, "I", purge?, realm.purge.period]
  end

end
