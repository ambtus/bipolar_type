# Restart required even in development mode when you modify this file.

class String

  def chip; self[1..-1]; end
  def second; self.chars.second; end

  def punctuate(punctuation = "."); self + punctuation; end
  def period; self.punctuate; end
  def comma; self.punctuate(","); end

  def parenthetical; "(#{self})"; end
  def parenthetical?; self.match(/\(/); end
  def nonparenthetical; self.split(" (").first; end
  def parenthetical_part; self.split(" (").second.chop; end

  MBTIS = ["ISTJ", "ISFJ", "INFJ", "INTJ", "ESTP", "ESFP", "ENFP", "ENTP", "ISTP", "ISFP", "INFP", "INTP", "ESTJ", "ESFJ", "ENFJ", "ENTJ"]

  def is_mbti?; MBTIS.include?(self); end

  def mbti_order
    letters = self.scan(/./)
    mbti_letters = [%w{I E i e}, %w{N S n s}, %w{T F t f}, %w{J P j p}]
    [letters & mbti_letters.first,
     letters & mbti_letters.second,
     letters & mbti_letters.third,
     letters & mbti_letters.fourth
    ].map(&:sort).flatten.compact.join
  end

  def a_or_an
    if self.mbti_order.length == self.length
      %w{I E i e N S n s F f}.include?(self.first) ? "an" : "a"
    else
      %w{a e i o u}.include?(self.first) ? "an" : "a"
    end
  end

  def an; [a_or_an, self].join(" "); end

  def ly
    if self.last == "y"
      self.chop + "ily"
    elsif self.last == "c"
      self + "ally"
    else
      self + "ly"
    end
  end

  # would it be better to check if countable?
  UNCOUNTABLE = %w{hope information fat confidence glucose cash credit income logic affection conflict power animosity sugar knowledge money protein interest hatred anger glycogen light meaning music color tone vocabulary meat checking pleasure pain head optimism pessimism focus trivia laughter discomfort tragedy comedy romance overtime humor net\ worth salary motivation functionality irritation unearned\ income hate love influence self\ esteem food}
  def uncountable?; UNCOUNTABLE.include?(self); end

  def few(inject=''); self.uncountable? ? "little #{inject} #{self}" : "few #{inject} #{self}"; end
  def many(inject=''); self.uncountable? ? "much #{inject} #{self}" : "many #{inject} #{self}"; end
  def fewer(inject=''); self.uncountable? ? "less #{inject} #{self}" : "fewer #{inject} #{self}"; end
  def dont; self.uncountable? ? "#{self} doesn’t" : "#{self} don’t"; end
  def those; self.uncountable? ? "that #{self}" : "those #{self}"; end
  def have; self.uncountable? ? "#{self} has" : "#{self} have"; end
  def they; self.uncountable? ? "it" : "they"; end
  def their; self.uncountable? ? "it’s" : "their"; end
  def them; self.uncountable? ? "it" : "them"; end
  def were; self.uncountable? ? "was" : "were"; end
  def are; self.uncountable? ? "is" : "are"; end
  def does; self.uncountable? ? "does" : "do"; end
  def they_are; [they, are].join(" "); end

  def it; self == "person" ? "them" : "it"; end
  def that; self == "people" ? "who" : "that"; end

  def s
    target = self.split.first
    transformation =
    if target == "die"
      target # singular they: they die => they die (not they die => he dies)
    elsif target.uncountable?
      target
    elsif target == "are"
      "is" # they are => it is
    elsif target == "where"
      "places" # go somewhere => go places
    elsif %w{do go express}.include?(target)
      target + "es"
    elsif target.end_with?("y")
      if %w{buy pay repay}.include?(target)
        target + "s"
      else
        target.chop + "ies"
      end
    else
      target + "s"
    end
    [transformation, self.split - [target]].join(" ").squish
  end

  def er
    target = self.split.first
    transformation = if %w{fat thin}.include?(target)
      target + target.last + "er"
    elsif %w{trustworthy expensive valuable hostile obese submissive knowledgeable creative defensive}.include?(target)
      "more " + target
    elsif target.end_with?("y")
      target.chop + "ier"
    elsif target.end_with?("e")
      target + "r"
    elsif %w{rich poor smart stupid loud quiet sweet strong weak clever light cheap}.include?(target)
      target + "er"
    else
      "more " + target
    end
    [transformation, self.split - [target]].join(" ").squish
  end

  def erer
    if self.er.starts_with?("more ")
      "more and more #{self}"
    else
      "#{self.er} and #{self.er}"
    end
  end

  def est
    target = self.split.first
    transformation = if %w{fat thin}.include?(target)
      target + target.last + "est"
    elsif %w{trustworthy expensive valuable hostile obese submissive knowledgeable creative  defensive}.include?(target)
      "most " + target
    elsif target.end_with?("y")
      target.chop + "iest"
    elsif target.end_with?("e")
      target + "st"
    elsif %w{rich poor smart stupid loud quiet sweet strong weak clever light cheap}.include?(target)
      target + "est"
    else
      "most " + target
    end
    [transformation, self.split - [target]].join(" ").squish
  end

  def ing
    if self.parenthetical?
      return [nonparenthetical.ing, parenthetical_part.ing.parenthetical].join(" ")
    end
    first, second = self.split("/")
    return [first, second].map(&:ing).join("/") if second
    target = self.split.first
    transformation = if target == "die"
      "dying"
    elsif target == "see"
      "seeing"
    elsif %w{lexical expressive local universal black salaried aerobic anaerobic}.include?(target)
      target
    elsif %w{fit put sweat beg forget shop hit run drop grab}.include?(target)
      target + target.last + "ing"
    elsif target.end_with?("e")
      target.chop + "ing"
    else
      target + "ing"
    end
    [transformation, self.split - [target]].join(" ").squish
  end


  IRREGULAR = %w{see eat are say hear think go break buy do find spend teach steal sell hit build tell make choose sing feed show throw forget lose}
  def irregular?; IRREGULAR.include?(self); end
  def past; %w{saw ate were said heard thought went broke bought did found spent taught stole sold hit built told made chose sang fed showed threw forgot lost}[IRREGULAR.index(self)]; end
  def perfect; %w{seen eaten been said heard thought gone broken bought done found spent taught stolen sold hit built told made chosen sung fed shown thrown forgotten lost}[IRREGULAR.index(self)]; end

  def ed
    first, second = self.split("/")
    return [first, second].map(&:ed).join("/") if second
    target = self.split.first
    transformation = if target.irregular?
      target.past
    elsif %w{fit beg shop grab}.include?(target)
      target + target.last + "ed"
    elsif target.end_with?("y")
      if %w{buy pay repay}.include?(target)
        target.chop + "id"
      else
        target.chop + "ied"
      end
    elsif target.end_with?("e")
      target + "d"
    else
      target + "ed"
    end
    [transformation, self.split - [target]].join(" ").squish
  end

  def en
    first, second = self.split("/")
    return [first, second].map(&:en).join("/") if second
    target = self.split.first
    transformation = if target.irregular?
      target.perfect
    elsif %w{fit beg shop grab}.include?(target)
      target + target.last + "ed"
    elsif target.end_with?("y")
      if %w{buy pay repay}.include?(target)
        target.chop + "id"
      else
        target.chop + "ied"
      end
    elsif target.end_with?("e")
      target + "d"
    else
      target + "ed"
    end
    [transformation, self.split - [target]].join(" ").squish
  end

end
