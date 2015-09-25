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

  def dominant
    raise unless is_mbti?
    letters = self.scan(/./)
    index = MBTIS.index(self)
    (index < 8 ? letters.values_at(0,1,3) : letters.values_at(0,2,3)).join
  end
  def auxiliary
    raise unless is_mbti?
    letters = self.scan(/./)
    index = MBTIS.index(self)
    first = letters.first == "I" ? "E" : "I"
    first + (index < 8 ? letters.values_at(2,3) : letters.values_at(1,3)).join
  end

  THEORETICALS = ["ISJ", "INJ", "ITP", "IFP", "ENP", "ESP", "EFJ", "ETJ"]
  def is_theoretical?; THEORETICALS.include?(self) ; end

  def mbti_order
    letters = self.scan(/./)
    mbti_letters = [%w{I E i e}, %w{N S n s}, %w{T F t f}, %w{J P j p}]
    [letters & mbti_letters.first,
     letters & mbti_letters.second,
     letters & mbti_letters.third,
     letters & mbti_letters.fourth
    ].map(&:sort).flatten.compact.join
  end

  def attitude_letters
    letters = self.scan(/./)
    attitudes = [%w{I E i e}, %w{J P j p}]
    [letters & attitudes.first,
     letters & attitudes.second,
    ].map(&:sort).flatten.map(&:downcase)
  end

  def attitudes; attitude_letters.collect{|l| Attitude.find(l)}; end

  def realm_letters
    letters = self.scan(/./)
    realms = [%w{N S n s}, %w{T F t f}]
    [letters & realms.first,
     letters & realms.second,
    ].map(&:sort).flatten.map(&:downcase)
  end

  def realms; realm_letters.collect{|l| Realm.find(l)}; end

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
    else
      self + "ly"
    end
  end

  # would it be better to check if countable?
  UNCOUNTABLE = %w{hope food information fat confidence glucose cash credit income logic affection conflict power animosity sugar knowledge money protein interest hatred anger glycogen light meaning music color tone vocabulary meat checking pleasure pain stomach heart head optimism pessimism focus trivia laughter discomfort tragedy comedy romance overtime humor net\ worth salary motivation functionality irritation}
  def uncountable?; UNCOUNTABLE.include?(self); end

  def few(inject=''); self.uncountable? ? "little #{inject}#{self}" : "few #{inject} #{self}"; end
  def some; self.uncountable? ? "some #{self}" : "a few #{self}"; end
  def many(inject=''); self.uncountable? ? "much #{inject} #{self}" : "many #{inject} #{self}"; end
  def fewer; self.uncountable? ? "less #{self}" : "fewer #{self}"; end
  def they; self.uncountable? ? "it" : "they"; end
  def them; self.uncountable? ? "it" : "them"; end
  def were; self.uncountable? ? "was" : "were"; end
  def are; self.uncountable? ? "is" : "are"; end
  def does; self.uncountable? ? "does" : "do"; end
  def they_are; [they, are].join(" "); end

  def s
    set, third = self.split(" or ")
    if third
      first, second = set.split(/, ?/)
      return [first, third].map(&:s).join(" or ") unless second
      return [first, second, third].map(&:s).to_sentence(:last_word_connector => ", or ")
    end
    target = self.split.first
    transformation =
    if target == "die"
      target # singular they: they die => they die (not they die => he dies)
    elsif target.uncountable?
      target
    elsif target == "are"
      "is" # they are => it is
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
    elsif target == "trustworthy"
      "more " + target
    elsif target.end_with?("y")
      target.chop + "ier"
    elsif %w{rich poor smart stupid loud quiet sweet strong weak clever}.include?(target)
      target + "er"
    else
      "more " + target
    end
    [transformation, self.split - [target]].join(" ").squish
  end

  def ing
    if self.parenthetical?
      return [nonparenthetical.ing, parenthetical_part.ing.parenthetical].join(" ")
    end
    set, third = self.split(" or ")
    if third
      first, second = set.split(/, ?/)
      return [first, third].map(&:ing).join(" or ") unless second
      return [first, second, third].map(&:ing).to_sentence(:last_word_connector => ", or ")
    end
    target = self.split.first
    transformation = if target == "die"
      "dying"
    elsif target == "see"
      "seeing"
    elsif %w{lexical expressive local universal black salaried aerobic anaerobic}.include?(target)
      target
    elsif %w{fit put sweat beg forget shop hit run drop}.include?(target)
      target + target.last + "ing"
    elsif target.end_with?("e")
      target.chop + "ing"
    else
      target + "ing"
    end
    [transformation, self.split - [target]].join(" ").squish
  end


  IRREGULAR = %w{see eat are say hear think go break buy do find spend teach steal sell hit build tell make}
  def irregular?; IRREGULAR.include?(self); end
  def past; %w{saw ate were said heard thought went broke bought did found spent taught stole sold hit built told made}[IRREGULAR.index(self)]; end
  def perfect; %w{seen eaten been said heard thought gone broken bought done found spent taught stolen sold hit built told made}[IRREGULAR.index(self)]; end

  def ed
    set, third = self.split(" or ")
    if third
      first, second = set.split(/, ?/)
      return [first, third].map(&:ed).join(" or ") unless second
      return [first, second, third].map(&:ed).to_sentence(:last_word_connector => ", or ")
    end
    target = self.split.first
    transformation = if target.irregular?
      target.past
    elsif %w{fit beg shop}.include?(target)
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
    set, third = self.split(" or ")
    if third
      first, second = set.split(/, ?/)
      return [first, third].map(&:en).join(" or ") unless second
      return [first, second, third].map(&:en).to_sentence(:last_word_connector => ", or ")
    end
    target = self.split.first
    transformation = if target.irregular?
      target.perfect
    elsif %w{fit beg shop}.include?(target)
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
