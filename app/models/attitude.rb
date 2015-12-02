class Attitude < Indexable

  ########
  LETTERS = %w{E P J I}
  ALL = LETTERS.collect{|letter| self.new letter}
  def path; super.downcase; end
  def self.paths; all.map(&:path); end
  all.each do |realm|
    define_singleton_method(realm.path) {all[LETTERS.index realm.string]}
  end
  ########

  def subtype_words(realm); %w{P J}.include?(letter) ? [realm, self] : [self, realm]; end
  def subtypes; Subtype.all.select{|s| s.attitude == self}; end

  def domain_adjective; index.even? ? "extroverted" : "introverted"; end
  def domain_noun; index < 2 ? "extrovert" : "introvert"; end
  def domain; Phrase.new [domain_adjective, domain_noun]; end
  def name; Phrase.new [domain.titleize, parenthesize]; end

end
