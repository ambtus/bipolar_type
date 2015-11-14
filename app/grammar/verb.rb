class Verb < Word

  def ed; is_irregular? ? PAST[irregular_index] : past; end

  def en; is_irregular? ? PERFECT[irregular_index] : past; end

  def ing
    if needs_doubling?
      suffix("#{last}ing")
    elsif is_exception?
      suffix("ing")
    elsif chars.last == "e"
      chop.suffix("ing")
    else
      suffix("ing")
    end
  end

  private

  ## add at the same index in IRREGULAR, PAST, and PERFECT
  IRREGULAR = %w{be see eat are say hear think go break buy do find spend teach steal sell hit build tell make choose sing feed show throw forget lose give get know}
  def is_irregular?; IRREGULAR.include?(@string); end
  def irregular_index; IRREGULAR.index(@string); end

  PAST = %w{been saw ate were said heard thought went broke bought did found spent taught stole sold hit built told made chose sang fed showed threw forgot lost gave got knew}.collect(&:to_word)

  PERFECT = %w{been seen eaten been said heard thought gone broken bought done found spent taught stolen sold hit built told made chosen sung fed shown thrown forgotten lost given gotten known}.collect(&:to_word)

  # exceptions to rules about ending in y or e
  EXCEPTIONS = %w{}
  def is_exception?; EXCEPTIONS.include?(@string); end

  DOUBLES = %w{stop}
  def needs_doubling?; DOUBLES.include?(@string); end

  VOWEL_Y = %w{buy pay repay}
  def is_vowel_y?; VOWEL_Y.include?(@string); end

  def past
    if chars.last == "y"
      if is_vowel_y?
        chop.suffix("id")
      else
        chop.suffix("ied")
      end
    elsif chars.last == "e"
      suffix("d")
    else
      suffix("ed")
    end
  end

end
