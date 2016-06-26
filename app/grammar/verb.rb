class Verb < Word

  def ed; irregular? ? PAST[irregular_index] : past; end

  def en; irregular? ? PERFECT[irregular_index] : past; end

  def ing
    if needs_doubling?
      suffix("#{last}ing")
    elsif exception?
      suffix("ing")
    elsif chars.last == "e"
      chop.suffix("ing")
    elsif chars.last == "c"
      suffix("king")
    else
      suffix("ing")
    end
  end

  def s
    if es?
      suffix("es")
    elsif chars.last == "y"
      if vowel_y?
        suffix("s")
      else
        chop.suffix("ies")
      end
    else
      suffix("s")
    end
  end

  def er
    if or?
      Noun.new (string + "or")
    elsif chars.last == "e"
      Noun.new (string + "r")
    elsif needs_doubling?
      Noun.new suffix("#{last}er")
    else
      Noun.new (string + "er")
    end
  end

  private

  ## add at the same index in IRREGULAR, PAST, and PERFECT
  IRREGULAR = %w{be see eat are say hear think go break buy do
    find spend teach steal sell hit quit build tell make choose sing feed
    show throw forget lose give get know run panic
    understand write take put}
  def irregular?; IRREGULAR.include?(@string); end
  def irregular_index; IRREGULAR.index(@string); end

  PAST = %w{been saw ate were said heard thought went broke bought did
    found spent taught stole sold hit quit built told made chose sang fed
    showed threw forgot lost gave got knew ran panicked
    understood wrote took put}.collect(&:to_word)

  PERFECT = %w{been seen eaten been said heard thought gone broken bought done
    found spent taught stolen sold hit quit built told made chosen sung fed
    shown thrown forgotten lost given gotten known run panicked
    understood written taken put}.collect(&:to_word)

  # exceptions to rules about ending in y or e
  EXCEPTIONS = %w{see play employ flee}
  def exception?; EXCEPTIONS.include?(@string); end

  DOUBLES = %w{stop grab shop run win submit drop forget quit}
  def needs_doubling?; DOUBLES.include?(@string); end

  VOWEL_Y = %w{pay repay say buy}
  def vowel_y?; VOWEL_Y.include?(@string); end

  ESSES = %w{do go teach guess express watch}
  def es?; ESSES.include?(@string); end

  ORS = %w{effect}
  def or?; ORS.include?(@string); end

  def past
    if needs_doubling?
      suffix("#{last}ed")
    elsif exception?
      suffix("ed")
    elsif chars.last == "y"
      if vowel_y?
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
