class Word < String

  def inspect; super.chip.chop; end

  %w{chop gsub}.each do |meth|
    def method_missing(meth, *arguments, &block)
      super.to_word_or_phrase
    end
  end

  def punctuate(punctuation); "#{self}#{punctuation}".to_word; end
  def period; self.punctuate("."); end
  def comma; self.punctuate(","); end
  def colon; self.punctuate(":"); end
  def semicolon; self.punctuate(";"); end

  def an?
   if self.is_function?
     %w{N S F}.include?(self.chars.first)
   else
     %w{a e i o u}.include?(self.chars.first)
   end
  end

  def a_or_an; self.an? ? "an".to_word : "a".to_word; end

  def an; [a_or_an, self].to_phrase; end

  def if_uncountable(yes, no=self); is_uncountable? ? yes : no; end
  def they; if_uncountable("it", "they").to_word; end
  def them; if_uncountable("it", "them").to_word; end
  def their; if_uncountable("its", "their").to_word; end
  def were; if_uncountable("was", "were").to_word; end
  def many; if_uncountable("much", "many").to_word; end
  def many_phrase; Phrase.new([many, self]); end
  def fewer; if_uncountable("less", "fewer").to_word; end
  def fewer_phrase; Phrase.new([fewer, self]); end
  def are; if_uncountable("is", "are").to_word; end
  def are_phrase; Phrase.new([are, self]); end

  def ly
    if self.last == "y"
      self.chop + "ily"
    elsif self.last == "c"
      self + "ally"
    else
      self + "ly"
    end.to_word
  end

  def er
    if needs_doubling?
      punctuate("#{last}er")
    elsif self.is_exception?
      Phrase.new(["more".to_word, self])
    elsif chars.last == "y"
      chop.punctuate("ier")
    elsif chars.last == "e"
      punctuate("r")
    elsif is_single_word?
      punctuate("er")
    else
      Phrase.new(["more".to_word, self])
    end
  end

  def erer
    if self.er.is_a?(Phrase)
      Phrase.new("more and".to_phrase + self.er)
    else
      Phrase.new([self.er, "and".to_word, self.er])
    end
  end

  def est
    if needs_doubling?
      punctuate("#{last}est")
    elsif self.is_exception?
      Phrase.new(["most".to_word, self])
    elsif chars.last == "y"
      chop.punctuate("iest")
    elsif chars.last == "e"
      punctuate("st")
    elsif is_single_word?
      punctuate("est")
    else
      Phrase.new(["most".to_word, self])
    end
  end

  def ing
    if needs_doubling?
      punctuate("#{last}ing")
    elsif is_exception?
      punctuate("ing")
    elsif chars.last == "e"
      chop.punctuate("ing")
    else
      punctuate("ing")
    end
  end

  def past
    if chars.last == "y"
      if is_vowel_y?
        chop.punctuate("id")
      else
        chop.punctuate("ied")
      end
    elsif chars.last == "e"
      chop.punctuate("d")
    else
      punctuate("ed")
    end
  end

  def ed; is_irregular? ? PAST[IRREGULAR.index(self)] : past; end
  def en; is_irregular? ? PERFECT[IRREGULAR.index(self)] : past; end

  def functions
    a = scan(/../).map(&:to_word)
    raise "#{a} are not all functions" unless a.all?(&:is_function?)
    return a
  end

  def invert
    raise "#{self} is not a function" unless is_function?
    (last == "i" ? chop + "e" : chop + "i").to_wordc
  end

  def mbti
    raise "mbti requires three functions" unless functions.size == 3
    wrapper = case functions.first.to_s
    when "Te"
      "ExTJ"
    when "Fe"
      "ExFJ"
    when "Ne"
      "ENxP"
    when "Se"
      "ESxP"
    when "Ti"
      "IxTP"
    when "Fi"
      "IxFP"
    when "Ni"
      "INxJ"
    when "Si"
      "ISxJ"
    end.to_word
    first_try = wrapper.gsub("x", functions.second.first)
    return first_try if first_try.is_mbti?
    second_try = wrapper.gsub("x", functions.third.first)
    return second_try if second_try.is_mbti?
    raise "#{functions} didn't produce a valid MBTI type"
  end

  def fix(i_or_e)
    raise "can only fix mbtis" unless is_mbti?
    case i_or_e
    when "i"
      gsub("E", "I")
    when "e"
      gsub("I", "E")
    else
      raise "#{i_or_e} is neither i nor e"
    end
  end

  #####################
  ### special words ###
  #####################

  FUNCTIONS = %w{T F S N}.multiply(%w{i e}).flatten.map(&:to_word)
  def is_function?; FUNCTIONS.include?(self); end

  MBTIS = %w{ISTP ISFP INTP INFP ISTJ ISFJ INTJ INFJ ESTP ESFP ENTP ENFP ESTJ ESFJ ENTJ ENFJ}.collect(&:to_word)
  def is_mbti?; MBTIS.include?(self); end


  ## if the word in realm.csv needs to be singular and plural
  ## make the method name plural, and add the singulars here
  ## plural defaults in order to differentiate they from them
  UNCOUNTABLE = %w{heart mind stomach food money confidence fat apathy anxiety hunger wealth certainty nourishment intonation outline protein}.collect(&:to_word)
  def is_uncountable?; UNCOUNTABLE.include?(self); end

  # exceptions to rules about ending in y or e
  EXCEPTIONS = %w{passionate}.map(&:to_word)
  def is_exception?; EXCEPTIONS.include?(self); end

  DOUBLES = %w{fat thin}.map(&:to_word)
  def needs_doubling?; DOUBLES.include?(self); end

  VOWELY = %w{buy pay repay}.map(&:to_word)
  def is_vowel_y?; VOWELY.include?(self); end

  SINGLES = %w{}.map(&:to_word)
  def is_single_word?; SINGLES.include?(self); end

  # add irregular verbs at the same place in all three
  IRREGULAR = %w{be see eat are say hear think go break buy do find spend teach steal sell hit build tell make choose sing feed show throw forget lose give get}.collect(&:to_word)
  PAST = %w{been saw ate were said heard thought went broke bought did found spent taught stole sold hit built told made chose sang fed showed threw forgot lost gave got}.collect(&:to_word)
  PERFECT = %w{been seen eaten been said heard thought gone broken bought done found spent taught stolen sold hit built told made chosen sung fed shown thrown forgotten lost given gotten}.collect(&:to_word)
  def is_irregular?; IRREGULAR.include?(self); end

end
