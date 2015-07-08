# Restart required even in development mode when you modify this file.

class String

  def punctuate(punctuation = "."); self + punctuation; end
  def parenthetical; "(#{self})"; end
  def parenthetical?; self.match(/\(/); end
  def nonparenthetical; self.split(" (").first; end
  def parenthetical_part; self.split(" (").second.chop; end

  MBTIS = ["ISFP", "ISFJ", "ISTP", "ISTJ", "INFP", "INFJ", "INTP", "INTJ", "ESFP", "ESFJ", "ESTP", "ESTJ", "ENFP", "ENFJ", "ENTP", "ENTJ"]

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
  UNCOUNTABLE = %w{hope work food information fat confidence glucose cash income logic affection conflict power animosity sugar knowledge money protein interest hatred anger glycogen light meaning music color tone vocabulary}
  def uncountable?; UNCOUNTABLE.include?(self.split.first); end

  def few; self.uncountable? ? "little #{self}" : "few #{self}"; end
  def many; self.uncountable? ? "much #{self}" : "many #{self}"; end
  def fewer; self.uncountable? ? "less #{self}" : "fewer #{self}"; end
  def they; self.uncountable? ? "it" : "they"; end
  def them; self.uncountable? ? "it" : "them"; end
  def were; self.uncountable? ? "was" : "were"; end
  def are; self.uncountable? ? "is" : "are"; end

  def s(word="hope")
    return self unless word.uncountable?
    set, third = self.split(" or ")
    if third
      first, second = set.split(/, ?/)
      return [first, third].map(&:s).join(" or ") unless second
      return [first, second, third].map(&:s).to_sentence(:last_word_connector => ", or ")
    end
    target = self.split.first
    transformation = if target == "die"
      target # singular they: they die => they die (not they die => he dies)
    elsif target == "are"
      "is" # they are => it is
    elsif %w{do go express}.include?(target)
      target + "es"
    elsif target.end_with?("y")
      if target == "buy"
        "buys"
      else
        target.chop + "ies"
      end
    else
      target + "s"
    end
    self.gsub(target, transformation)
  end

  def more
    if self.match(" or ")
      [self, "more"].join(" ")
    else
      self.split.insert(1, "more").join(" ")
    end
  end

  def er
    target = self.split.first
    transformation = if target == "fat"
      "fatter"
    elsif target == "thin"
      "thinner"
    elsif %w{rich poor smart stupid loud quiet}.include?(target)
      target + "er"
    else
      "more " + target
    end
    self.gsub(target, transformation)
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
    elsif %w{fit put run beg forget shop}.include?(target)
      target + target.last + "ing"
    elsif target.end_with?("e")
      target.chop + "ing"
    else
      target + "ing"
    end
    self.gsub(target, transformation)
  end


  IRREGULAR = %w{see eat are say hear think go break buy do find spend teach beg steal}
  def irregular?; IRREGULAR.include?(self); end
  def past; %w{saw ate were said heard thought went broke bought did found spent taught begged stole}[IRREGULAR.index(self)]; end

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
    elsif target.end_with?("y")
      target.chop + "ied"
    elsif target.end_with?("e")
      target + "d"
    else
      target + "ed"
    end
    self.gsub(target, transformation)
  end


end
