# Restart required even in development mode when you modify this file.

# A list of all the methods defined here to prevent breaking rails by overwriting something in use
%w{chip second third fourth to_word words to_phrase first_word is_mbti? s ed en ly ing an some enough  many too_much too_little a_few plural? little few more fewer less much many that those is are them it they}.each do |meth|
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

  def first_word; split.first; end

  MBTIS = %w{ISTP ISFP INTP INFP
             ISTJ ISFJ INTJ INFJ
             ESTP ESFP ENTP ENFP
             ESTJ ESFJ ENTJ ENFJ}
  def is_mbti?; MBTIS.include? self; end

  def s
    return "relaxes" if self=="relax"
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
    return "thought" if self=="think"
    return "told" if self=="tell"
    return "spent" if self=="spend"
    return "made" if self=="make"
    return "heard" if self=="hear"
    return "did" if self=="do"
    return "fought" if self=="fight"
    return "ran" if self=="run"
    return "hit" if self=="hit"
    return "saw" if self=="see"
    return "shopped" if self=="shop"
    return "planned" if self=="plan"
    return "understood" if self=="understand"
    return "lost" if self=="lose"
    return "held" if self=="hold"
    return "built" if self=="build"
    return "spoke" if self=="speak"
    if self.match(" ")
      first, second = self.split(' ', 2)
      [first.ed, second].join(" ")
    else
      self.sub(/e$/, "") + "ed"
    end
  end

  def en
    return "eaten" if self=="eat"
    return "forgotten" if self=="forget"
    return "done" if self=="do"
    return "run" if self=="run"
    return "seen" if self=="see"
    return "paid" if self=="pay"
    return "gone" if self=="go"
    return "spoken" if self=="speak"
    if self.match(" ")
      first, second = self.split(' ', 2)
      [first.en, second].join(" ")
    else
      self.ed
    end
  end

  def ly; self + "ly"; end

  def ing
    return "lying" if self=="lie"
    return "listening" if self=="listen"
    return "abandoning" if self=="abandon"
    return "quitting" if self=="quit"
    return "visiting" if self=="visit"
    return "positing" if self=="posit"
    return "developing" if self=="develop"
    return "panicking" if self=="panic"
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
  def an
    %w{a e i o u}.include?(self.first) ? "an" : "a"
  end
  def some
    if self.match(" ")
      first, second = self.split(' ', 2)
      [first, "some", second].join(" ")
    else
      "#{self} some"
    end
  end
  def a_lot
    if self.match(" ")
      first, second = self.split(' ', 2)
      [first, second.many, second].join(" ")
    else
      "#{self} a lot"
    end
  end
  def a_few
    if self.match(" ")
      first, second = self.split(' ', 2)
      [first, "a", second.few, second].join(" ")
    else
      "#{self} a little"
    end
  end
  def too_much
    if self.match(" ")
      first, second = self.split(' ', 2)
      [first, "too", second.much, second].join(" ")
    else
      "#{self} too much"
    end
  end
  def too_little
    if self.match(" ")
      first, second = self.split(' ', 2)
      [first, "too", second.little, second].join(" ")
    else
      "#{self} too little"
    end
  end

  def plural?
    return true if self == "people"
    return true if self[-1] == "s"
    return false
  end

  def little; plural? ? "few" : "little"; end
  alias few :little
  def fewer; plural? ? "fewer" : "less"; end
  alias less :fewer
  def more; "more"; end
  def much; plural? ? "many" : "much"; end
  alias many :much
  def that; plural? ? "those" : "that"; end
  alias those :that
  def is; plural? ? "are" : "is"; end
  alias are :is
  def them; plural? ? "them" : "it"; end
  alias it :them
  def they; plural? ? "they" : "it"; end

end
