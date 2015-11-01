# Restart required even in development mode when you modify this file.

class String

  def chip; self[1..-1]; end
  def squash; self.gsub(" ", "");end
  def second; self.chars.second; end
  def third; self.chars.third; end
  def fourth; self.chars.fourth; end

  def insert_word(string); self.split.insert(1,string).join(" "); end

  def punctuate(punctuation = "."); self + punctuation; end
  def period; self.punctuate; end
  def comma; self.punctuate(","); end

  def parenthetical; "(#{self})"; end
  def parenthetical?; self.match(/\(/); end
  def nonparenthetical; self.split(" (").first; end
  def parenthetical_part; self.split(" (").second.chop; end

  def a_or_an; %w{a e i o u}.include?(self.first) ? "an" : "a"; end

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
  UNCOUNTABLE = %w{hope information fat confidence glucose cash credit income logic affection conflict power animosity sugar knowledge money protein interest hatred anger glycogen light meaning music color tone vocabulary meat checking pleasure pain head optimism pessimism focus trivia laughter discomfort tragedy comedy romance overtime humor net\ worth salary motivation functionality irritation unearned\ income influence self\ esteem food intonation the\ right\ answer rhythm public\ opinion shame guilt empathy potential\ energy}
  def uncountable?; UNCOUNTABLE.include?(self); end

  def few(inject=''); self.uncountable? ? "little #{inject} #{self}" : "few #{inject} #{self}"; end
  def many(inject=''); self.uncountable? ? "much #{inject} #{self}" : "many #{inject} #{self}"; end
  def fewer(inject=''); self.uncountable? ? "less #{inject} #{self}" : "fewer #{inject} #{self}"; end
  def more(inject=''); self.uncountable? ? "more #{inject} #{self}" : "more #{inject} #{self}"; end
  def those(inject=''); self.uncountable? ? "that #{inject} #{self}" : "those #{inject} #{self}"; end
  def are(inject=''); self.uncountable? ? "#{self} #{inject} is" : "#{self} #{inject} are"; end
  def dont; self.uncountable? ? "#{self} doesn’t" : "#{self} don’t"; end
  def have; self.uncountable? ? "#{self} has" : "#{self} have"; end
  def they; self.uncountable? ? "it" : "they"; end
  def their; self.uncountable? ? "its" : "their"; end
  def them; self.uncountable? ? "it" : "them"; end
  def were; self.uncountable? ? "was" : "were"; end
  def does; self.uncountable? ? "does" : "do"; end
  def they_are; [they, are.split.last].join(" "); end

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
    elsif %w{trustworthy expensive valuable hostile obese submissive knowledgeable creative defensive alone sure miserly unsure trite}.include?(target)
      "more " + target
    elsif target.end_with?("y")
      target.chop + "ier"
    elsif target.end_with?("e")
      target + "r"
    elsif %w{rich poor smart stupid loud quiet sweet strong weak clever light cheap calm}.include?(target)
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
    elsif %w{trustworthy expensive valuable hostile obese submissive knowledgeable creative defensive alone sure miserly unsure trite}.include?(target)
      "most " + target
    elsif target.end_with?("y")
      target.chop + "iest"
    elsif target.end_with?("e")
      target + "st"
    elsif %w{rich poor smart stupid loud quiet sweet strong weak clever light cheap calm}.include?(target)
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


  IRREGULAR = %w{be see eat are say hear think go break buy do find spend teach steal sell hit build tell make choose sing feed show throw forget lose give get}
  def irregular?; IRREGULAR.include?(self); end
  def past; %w{been saw ate were said heard thought went broke bought did found spent taught stole sold hit built told made chose sang fed showed threw forgot lost gave got}[IRREGULAR.index(self)]; end
  def perfect; %w{been seen eaten been said heard thought gone broken bought done found spent taught stolen sold hit built told made chosen sung fed shown thrown forgotten lost given gotten}[IRREGULAR.index(self)]; end

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
