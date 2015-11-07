class Word

  def initialize(string)
    raise "#{string} is not a string" unless string.respond_to?(:to_str)
    @string = string.to_str
  end

  def inspect; @string.inspect.chip.chop; end
  def to_word; self; end
  def to_s; @string; end
  alias_method :to_str, :to_s

  def method_missing(meth, *arguments, &block)
    @string.send(meth, *arguments, &block).to_word_or_phrase
  end

  def punctuate(punctuation); "#{@string}#{punctuation}".to_word; end
  def period; punctuate("."); end
  def comma; punctuate(","); end
  def colon; punctuate(":"); end
  def semicolon; punctuate(";"); end
  def exclaim; punctuate("!"); end
  def parenthetical; "(#{@string})".to_word; end

  def an?
   if is_function?
     %w{N S F}.include?(@string.chars.first)
   else
     %w{a e i o u}.include?(@string.chars.first)
   end
  end

  def a_or_an; an? ? "an".to_word : "a".to_word; end

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
    if chars.last == "y"
      self.chop + "ily"
    elsif chars.last == "c"
      self + "ally"
    else
      self + "ly"
    end.to_word
  end

  def er
    if needs_doubling?
      punctuate("#{last}er")
    elsif @string.is_exception?
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

  def ed; is_irregular? ? PAST_WORDS[IRREGULAR.index(@string)] : past; end
  def en; is_irregular? ? PERFECT_WORDS[IRREGULAR.index(@string)] : past; end

  def functions
    a = scan(/../).map(&:to_word)
    raise "#{a} are not all functions" unless a.all?(&:is_function?)
    return a
  end

  def invert
    raise "#{self} is not a function" unless is_function?
    (last == "i" ? chop + "e" : chop + "i").to_wordc
  end

  def wrapper
    case @string
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
    else
      raise "#{self} is not a function"
    end.to_word
  end

  def wrap(other); wrapper.gsub("x", other.first); end

  def fix(i_or_e)
    raise "can't fix #{self}" unless is_mbti?
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

  FUNCTIONS = %w{T F S N}.multiply(%w{i e}).flatten
  def is_function?; FUNCTIONS.include?(@string); end

  MBTIS = %w{ISTP ISFP INTP INFP ISTJ ISFJ INTJ INFJ ESTP ESFP ENTP ENFP ESTJ ESFJ ENTJ ENFJ}
  def is_mbti?; MBTIS.include?(@string); end


  ## if the word in realm.csv needs to be singular and plural
  ## make the method name plural, and add the singulars here
  ## plural defaults in order to differentiate they from them
  UNCOUNTABLE = %w{heart mind stomach food money confidence fat apathy anxiety hunger wealth certainty nourishment intonation outline protein}
  def is_uncountable?; UNCOUNTABLE.include?(@string); end

  # exceptions to rules about ending in y or e
  EXCEPTIONS = %w{passionate}
  def is_exception?; EXCEPTIONS.include?(@string); end

  DOUBLES = %w{fat thin}
  def needs_doubling?; DOUBLES.include?(@string); end

  VOWELY = %w{buy pay repay}
  def is_vowel_y?; VOWELY.include?(@string); end

  SINGLES = %w{}
  def is_single_word?; SINGLES.include?(@string); end

  # add irregular verbs at the same place in all three
  IRREGULAR = %w{be see eat are say hear think go break buy do find spend teach steal sell hit build tell make choose sing feed show throw forget lose give get}
  def is_irregular?; IRREGULAR.include?(@string); end

  PAST_WORDS = %w{been saw ate were said heard thought went broke bought did found spent taught stole sold hit built told made chose sang fed showed threw forgot lost gave got}.collect(&:to_word)
  PERFECT_WORDS = %w{been seen eaten been said heard thought gone broken bought done found spent taught stolen sold hit built told made chosen sung fed shown thrown forgotten lost given gotten}.collect(&:to_word)

end
