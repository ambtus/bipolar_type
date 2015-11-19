class Phrase

  def initialize(array)
    @words = array.flatten.collect{|w| w.words}.flatten
    @words.check_constraints(Word,2)
  end
  attr_reader :words

  def <=>(other); self.to_s <=> other.to_s; end

  ## specific phrases
  def self.early; new "Monday morning".split; end
  def self.late; new "Friday night".split; end

  def self.early_duration; new "during the work day".split; end
  def self.late_duration; new "on evenings and weekends".split; end
  def self.duration(early, late)
    new [early, early_duration, "and", late, late_duration]
  end

  ## methods that return a string
  def to_s; words.join(" "); end
  def to_str; words.join(" "); end
  def path; words.join(""); end

  ## methods that return a word
  def inspect; words.join("•").to_word; end
  def first; words.first; end
  def last; words.last; end

  ## methods that return an array of words
  def first_words; words[0..-2]; end
  def mid_words; words[1..-2]; end
  def last_words; words[1..-1]; end

  ## first word methods
  def prefix(prefix); Phrase.new [first.prefix(prefix), last_words]; end
  %w{open_paren capitalize ed en ing s}.each do |meth|
    define_method(meth) {Phrase.new [first.send(meth), last_words]}
  end

  ## last word methods
  def suffix(suffix); Phrase.new [first_words, last.suffix(suffix)]; end
  Word.last_word_methods.each do |meth|
    define_method(meth) {Phrase.new [first_words, last.send(meth)]}
  end

  ## entire phrase methods
  def reverse; Phrase.new words.reverse; end
  def titleize; Phrase.new words.map(&:capitalize); end
  def parenthesize
    Phrase.new [first.open_paren, mid_words, last.close_paren]
  end

end
