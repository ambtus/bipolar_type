class Word

  def initialize(string); @string = string.to_str; end
  attr_reader :string

  def inspect; string.inspect.chip.chop; end

  def to_s; string; end
  def to_str; string; end
  def chars; string.chars; end
  def path; to_s; end
  def to_partial_path; to_s; end
  def words; [self]; end
  def to_word; self; end

  def first_word; self; end  

  %w{first second third fourth fifth last}.each do |meth|
    define_method(meth) {Word.new chars.send(meth)}
  end

  def method_missing(meth, *arguments, &block)
    result = string.send(meth, *arguments, &block)
    result.respond_to?(:to_str) ? result.to_word_or_phrase : result
  end

  def prefix(prefix); "#{prefix}#{string}".to_word; end
  def open_paren; prefix("("); end

  def self.last_word_methods
    %w{period comma colon semicolon exclaim! question? ellipsis close_paren}
  end
  def suffix(suffix); "#{to_s}#{suffix}".to_word; end
  def period; suffix("."); end
  def comma; suffix(","); end
  def colon; suffix(":"); end
  def semicolon; suffix(";"); end
  def exclaim!; suffix("!"); end
  def question?; suffix("?"); end
  def ellipsis; suffix("…"); end
  def close_paren; suffix(")"); end

  def surround(prefix, suffix); "#{prefix}#{to_s}#{suffix}".to_word; end
  def air_quotes; surround("“", "”"); end
  def parenthesize; surround("(", ")"); end

  def an?
     if chars.length == 1
       %w{F H L M O R S X}.include?(string)
     else
       %w{a e i o u A E I O U}.include?(chars.first)
     end
  end

  def an; an? ? "an".to_word : "a".to_word; end

  def an_phrase; Phrase.new [an, self]; end

end
