# Restart required even in development mode when you modify this file.

class String

  def chip; self[1..-1]; end
  def to_word; Word.new(self); end
  def to_phrase; Phrase.new(self.split.map(&:to_word)); end
  def to_word_or_phrase; match(" ") ? to_phrase : to_word; end

end
