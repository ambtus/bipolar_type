class Phrase
  def initialize(array)
    @words = array.flatten.collect{|w| w.words}.flatten
    @words.check_constraints(Word,2)
  end
  attr_reader :words

  ## methods that return a string
  def to_s; words.join(" "); end
  def to_str; words.join(" "); end

  ## methods that return a word
  def inspect; words.join("•").to_word; end
  def first; words.first; end
  def last; words.last; end

  ## methods that return an array of words
  def first_words; words[0..-2]; end
  def mid_words; words[1..-2]; end
  def last_words; words[1..-1]; end

  ## first word methods
  %w{ing ed en}.each do |meth|
    define_method(meth) {Phrase.new [first.send(meth), last_words]}
  end

  ## last word methods
  %w{period comma colon semicolon exclaim question}.each do |meth|
    define_method(meth) {Phrase.new [first_words, last.send(meth)]}
  end

  ## entire phrase methods
  def reverse; Phrase.new words.reverse; end
  def titleize; Phrase.new words.map(&:capitalize); end
  def parenthetical; Phrase.new [first.prefix("("), mid_words, last.suffix(")")]; end

end
