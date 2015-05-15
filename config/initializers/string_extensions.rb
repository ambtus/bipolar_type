# Restart required even in development mode when you modify this file.

class String

  def punctuate(punctuation = "."); self + punctuation; end

  def mbti_order
    letters = self.scan(/./)
    mbti_letters = [%w{I E i e}, %w{N S n s}, %w{T F t f}, %w{J P j p}]
    [letters & mbti_letters.first,
     letters & mbti_letters.second,
     letters & mbti_letters.third,
     letters & mbti_letters.fourth
    ].flatten.compact.join
  end

  # would it be better to check if countable?
  UNCOUNTABLE = %w{hope work food information fat confidence glucose cash income internal\ logic affection conflict power animosity sugar knowledge money}
  def uncountable?; UNCOUNTABLE.include?(self); end

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
    target = self.split.first
    transformation = if target == "die"
      "dying"
    elsif target == "see"
      "seeing"
    elsif %w{fit put}.include?(target)
      target + "ting"
    elsif target.end_with?("e")
      target.chop + "ing"
    else
      target + "ing"
    end
    self.gsub(target, transformation)
  end


  def s
    target = self.split.first
    transformation = if target == "die"
      target # singular they: they die => they die (not they die => he dies)
    elsif target == "are"
      "is" # they are => it is
    elsif %w{do go express}.include?(target)
      target + "es"
    else
      target + "s"
    end
    self.gsub(target, transformation)
  end

  def ed
    target = self.split.first
    transformation = if target == "eat"
      "ate"
    elsif target == "are"
      "were"
     elsif target == "say"
      "said"
   elsif target == "hear"
      "heard"
    elsif target == "think"
      "thought"
    elsif target == "go"
      "went"
    elsif target == "break"
      "broke"
    elsif target == "buy"
      "bought"
    elsif target == "do"
      "did"
    elsif target == "find"
      "found"
    elsif target == "spend"
      "spent"
    elsif target == "teach"
      "taught"
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
