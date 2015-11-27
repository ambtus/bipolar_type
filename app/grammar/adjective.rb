class Adjective < Word

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
      suffix("#{last}er")
    elsif is_exception?
      Phrase.new ["more", self]
    elsif chars.last == "y"
      chop.suffix("ier")
    elsif chars.last == "e"
      suffix("r")
    elsif is_single_word?
      suffix("er")
    else
      Phrase.new ["more", self]
    end
  end

  def erer
    if er.is_a?(Phrase)
      Phrase.new ["more and", er]
    else
      Phrase.new [er, "and", er]
    end
  end

  def ererer
    if er.is_a?(Phrase)
      Phrase.new ["more and more and", er]
    else
      Phrase.new [er, "and", er, "and", er]
    end
  end

  def est
    if needs_doubling?
      suffix("#{last}est")
    elsif is_exception?
      Phrase.new ["most", self]
    elsif chars.last == "y"
      chop.suffix("iest")
    elsif chars.last == "e"
      suffix("st")
    elsif is_single_word?
      suffix("est")
    else
      Phrase.new ["most", self]
    end
  end

  private
  DOUBLES = %w{fat thin}
  def needs_doubling?; DOUBLES.include?(@string); end

  # exceptions to rules about ending in y or e
  EXCEPTIONS = %w{appreciate unsure responsible}
  def is_exception?; EXCEPTIONS.include?(@string); end

  SINGLES = %w{sweet smart rich poor sick}
  def is_single_word?; SINGLES.include?(@string); end

end
