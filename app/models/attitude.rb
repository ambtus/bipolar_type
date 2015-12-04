class Attitude < Indexable

  ########
  LETTERS = %w{E e i I}
  ALL = LETTERS.collect{|letter| self.new letter}
  ########

  def subtype_words(realm); %w{e i}.include?(letter) ? [realm, self] : [self, realm]; end
  def generic_words; subtype_words("X".to_word); end
  def inspect; generic_words.join; end
  def to_s; inspect; end
  def subtypes; Subtype.all.select{|s| s.attitude == self}; end

  def path; inspect.downcase; end
  def self.paths; all.map(&:path); end
  self.paths.each_with_index { |path, index| define_singleton_method(path) {ALL[index]} }

  def domain_adjective; choose Adjective, %w{extroverted introverted extroverted introverted}; end
  def domain_noun; choose Noun, %w{extrovert extrovert introvert introvert}; end
  def domain; Phrase.new [domain_adjective, domain_noun]; end
  def name; Phrase.new [domain.titleize, parenthesize]; end

  AFFECTS = %w{wonderful bad good horrible}
  def manic_affect; Adjective.new AFFECTS[index]; end
  def depressed_affect; Adjective.new AFFECTS.reverse[index]; end

end
