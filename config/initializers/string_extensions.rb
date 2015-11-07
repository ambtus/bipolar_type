# Restart required even in development mode when you modify this file.

%w{chip to_word to_phrase to_word_or_phrase}.each do |meth|
 raise "#{meth} is already defined in String" if String.method_defined?(meth)
end

class String

  def chip; self[1..-1]; end
  def to_word; Word.new(self); end
  def to_phrase; Phrase.new(self.split.map(&:to_word)); end
  def to_word_or_phrase; match(" ") ? to_phrase : to_word; end

end
