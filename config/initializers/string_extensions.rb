# Restart required even in development mode when you modify this file.

# A list of all the methods defined here to prevent breaking rails by overwriting something in use
%w{chip second third fourth to_word words to_phrase is_mbti? s ed ly ing enough more too_much plural? little few fewer less much many that those is are them it they}.each do |meth|
 raise "#{meth} is already defined in String class" if String.method_defined?(meth)
end

class String

  def chip; self[1..-1]; end
  def second; chars.second; end
  def third; chars.third; end
  def fourth; chars.fourth; end
  def to_word; Word.new self ; end
  def words; split.map(&:to_word); end
  def to_phrase; Phrase.new words; end
  def to_word_or_phrase; words.size > 1 ? to_phrase : words.first; end

  MBTIS = %w{ISTP ISFP INTP INFP
             ISTJ ISFJ INTJ INFJ
             ESTP ESFP ENTP ENFP
             ESTJ ESFJ ENTJ ENFJ}
  def is_mbti?; MBTIS.include? self; end

  def s
    return "people" if self=="person"
    return "speaches" if self=="speach"
    if self.match(" ")
      first, second = self.split(' ', 2)
      [first.s, second].join(" ")
    else
      self.sub(/e?y$/, "ie") + "s"
    end
  end
  def ed
    return "ate" if self=="eat"
    return "forgot" if self=="forget"
    return "left" if self=="leave"
    return "sold" if self=="sell"
    return "felt" if self=="feel"
    return "bought" if self=="buy"
    return "told" if self=="tell"
    return "spent" if self=="spend"
    return "made" if self=="make"
    return "heard" if self=="hear"
    return "did" if self=="do"
    return "fought" if self=="fight"
    return "ran" if self=="run"
    return "hit" if self=="hit"
    return "saw" if self=="see"
    if self.match(" ")
      first, second = self.split(' ', 2)
      [first.ed, second].join(" ")
    else
      self.sub(/e$/, "") + "ed"
    end
  end

  def ly; self + "ly"; end

  def ing
    return "lying" if self=="lie"
    return "listening" if self=="listen"
    if self.match(" ")
      first, second = self.split(' ', 2)
      [first.ing, second].join(" ")
    elsif self.match("/")
      first, second = self.split('/', 2)
      [first.ing, second.ing].join("/")
    else
      self.sub(/([^aeiou])([aeiou])([bpntg])$/, '\1\2\3\3').sub(/([^e])e$/, '\1') + "ing"
    end
  end

  def enough
    if self.match(" ")
      first, second = self.split(' ', 2)
      [first, "enough", second].join(" ")
    else
      "#{self} enough"
    end
  end
  def more
    if self.match(" ")
      first, second = self.split(' ', 2)
      [first, "more", second].join(" ")
    else
      "#{self} more"
    end
  end
  def too_much
    if self.match(" ")
      first, second = self.split(' ', 2)
      [first, "too much", second].join(" ")
    else
      "#{self} too much"
    end
  end

  def plural?
    return true if self == "people"
    return true if self[-1] == "s"
    return false
  end

  def little; plural? ? "few" : "little"; end
  def few; little; end
  def fewer; plural? ? "fewer" : "less"; end
  def less; fewer; end
  def much; plural? ? "many" : "much"; end
  def many; much; end
  def that; plural? ? "those" : "that"; end
  def those; that; end
  def is; plural? ? "are" : "is"; end
  def are; is; end
  def them; plural? ? "them" : "it"; end
  def it; them; end
  def they; plural? ? "they" : "it"; end

end
