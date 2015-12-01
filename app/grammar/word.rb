class Word

  def initialize(string); @string = string.to_str; end
  attr_reader :string

  def inspect; string.inspect.chip.chop; end

  def to_s; string; end
  def to_str; string; end
  def chars; string.chars; end
  def path; to_s; end
  def words; [self]; end
  def to_word; self; end

  def method_missing(meth, *arguments, &block)
    result = string.send(meth, *arguments, &block)
    result.respond_to?(:to_str) ? result.to_word_or_phrase : result
  end

  def prefix(prefix); "#{prefix}#{string}".to_word; end
  def open_paren; prefix("("); end

  def self.last_word_methods
    %w{period comma colon semicolon exclaim! question? ellipsis close_paren}
  end
  def suffix(suffix); "#{string}#{suffix}".to_word; end
  def period; suffix("."); end
  def comma; suffix(","); end
  def colon; suffix(":"); end
  def semicolon; suffix(";"); end
  def exclaim!; suffix("!"); end
  def question?; suffix("?"); end
  def ellipsis; suffix("…"); end
  def close_paren; suffix(")"); end

  def surround(prefix, suffix); "#{prefix}#{string}#{suffix}".to_word; end
  def air_quotes; surround("“", "”"); end
  def parenthesize; surround("(", ")"); end

  def an?
     if chars.length == 1
       %w{A E F H L M O R S X}.include?(string)
     else
       %w{a e i o u}.include?(chars.first)
     end
  end

  def an; an? ? "an".to_word : "a".to_word; end

  def an_phrase; Phrase.new [an, self]; end

end
