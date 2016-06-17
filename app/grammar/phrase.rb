class Phrase

  def initialize(array)
    @words = array.flatten.compact.collect{|w| w.words}.flatten
    @words.check_constraints(Word,2)
  end
  attr_reader :words

  def <=>(other); self.to_s <=> other.to_s; end

 def self.optional(one, two)
    if one && two
      self.new [one, two]
    else
      one || two
    end
  end

  def first_word; words.first; end

  ## specific phrases
  def self.early; new "Monday morning in the winter".split; end
  def self.late; new "Saturday night in the spring".split; end

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
  def join; words.join; end

  ## methods that return an array of words
  def first_words; words[0..-2]; end
  def mid_words; words[1..-2]; end
  def last_words; words[1..-1]; end

  ## first word methods
  def prefix(prefix); Phrase.new [first.prefix(prefix), last_words]; end
  %w{open_paren capitalize an_phrase}.each do |meth|
    define_method(meth) {Phrase.new [first.send(meth), last_words]}
  end

  ## last word methods
  def suffix(suffix); Phrase.new [first_words, last.suffix(suffix)]; end
  Word.last_word_methods.each do |meth|
    define_method(meth) {Phrase.new [first_words, last.send(meth)]}
  end

  ## entire phrase methods

  # verb methods
  %w{ed en ing s}.each do |meth|
    define_method(meth) {Phrase.new words.collect{|w| w.is_a?(Verb) ? w.send(meth) : w}}
  end

  # noun methods
  %w{many few fewer fewest those}.each do |meth|
    define_method(meth + "_phrase") do
      if words.first.is_a?(Adjective) && words.second.is_a?(Noun)
        Phrase.new [words.second.send(meth), words.first, words.second]
      else
        Phrase.new words.collect{|w| w.is_a?(Noun) ? [w.send(meth), w] : w}
      end
    end
  end
  def more_phrase; Phrase.new words.collect{|w| w.is_a?(Noun) ? ["more", w] : w}; end
  # all words methods
  def reverse; Phrase.new words.reverse; end
  def titleize; Phrase.new words.map(&:capitalize); end
  def parenthesize
    Phrase.new [first.open_paren, mid_words, last.close_paren]
  end
  def gsub(pattern, replacement)
    Phrase.new words.collect{|w| w.gsub(pattern, replacement)}
  end

end
