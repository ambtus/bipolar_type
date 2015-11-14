class Adjective < Word

  def to_noun; Noun.new(string.chop + "ity"); end

  def ly
    if chars.last == "y"
      self.chop + "ily"
    elsif chars.last == "c"
      self + "ally"
    else
      self + "ly"
    end
  end

  def er
    if needs_doubling?
      punctuate("#{last}er")
    elsif is_exception?
      ["more", self].to_phrase
    elsif chars.last == "y"
      chop.punctuate("ier")
    elsif chars.last == "e"
      punctuate("r")
    elsif is_single_word?
      punctuate("er")
    else
      ["more", self].to_phrase
    end
  end

  def erer
    if er.is_a?(Phrase)
      ["more", "and", er].to_phrase
    else
      [er, "and", er].to_phrase
    end
  end

  def est
    if needs_doubling?
      punctuate("#{last}est")
    elsif is_exception?
      ["most", self].to_phrase
    elsif chars.last == "y"
      chop.punctuate("iest")
    elsif chars.last == "e"
      punctuate("st")
    elsif is_single_word?
      punctuate("est")
    else
      ["most", self].to_phrase
    end
  end

  private
  DOUBLES = %w{fat thin}
  def needs_doubling?; DOUBLES.include?(@string); end

  # exceptions to rules about ending in y or e
  EXCEPTIONS = %w{appreciate}
  def is_exception?; EXCEPTIONS.include?(@string); end

  SINGLES = %w{}
  def is_single_word?; SINGLES.include?(@string); end

end
