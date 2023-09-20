# Restart required even in development mode when you modify this file.

# A list of all the methods defined here to prevent breaking rails by overwriting something in use
%w{chip squash second third fourth words to_phrase n first_word last_words last_word parenthesize is_mbti? s ed en ly ing an some enough many too_much too_little a_few plural? little few more fewer less much many that those is are was were them it they has have do does}.each do |meth|
 raise "#{meth} is already defined in String class" if String.method_defined?(meth)
end

class String

  def chip; self[1..-1]; end
  def squash; self.gsub(/\s/, '');end
  def second; chars.second; end
  def third; chars.third; end
  def fourth; chars.fourth; end
  def words; split; end

  def n; words.size - 1;end
  def first_word; words.first; end
  def last_words; words.last(n).to_phrase; end
  def last_word; words.last; end
  def parenthesize; "(#{self})"; end

  MBTIS = %w{ISTP ISFP INTP INFP
             ISTJ ISFJ INTJ INFJ
             ESTP ESFP ENTP ENFP
             ESTJ ESFJ ENTJ ENFJ}
  def is_mbti?; MBTIS.include? self; end

  def s
    return "watches" if self=="watch"
    return "buys" if self=="buy"
    return "says" if self=="say"
    return "does" if self=="do"
    return "goes" if self=="go"
    return "relaxes" if self=="relax"
    if self.match(" ")
      first, second = self.split(' ', 2)
      [first.s, second].join(" ")
    elsif self.match("/")
      first, second = self.split('/', 2)
      [first.s, second.s].join("/")
    else
      self.sub(/e?y$/, "ie") + "s"
    end
  end
  def ed
    return "sat" if self=="sit"
    return "went" if self=="go"
    return "fed" if self=="feed"
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
    return "shown" if self=="show"
    return "eaten" if self=="eat"
    return "forgotten" if self=="forget"
    return "done" if self=="do"
    return "run" if self=="run"
    return "seen" if self=="see"
    return "paid" if self=="pay"
    return "said" if self=="say"
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
    return "hardening" if self=="harden"
    return "lying" if self=="lie"
    return "listening" if self=="listen"
    return "abandoning" if self=="abandon"
    return "quitting" if self=="quit"
    return "visiting" if self=="visit"
    return "positing" if self=="posit"
    return "developing" if self=="develop"
    return "panicking" if self=="panic"
    if self.match(" and ")
      first, second = self.split(' and ', 2)
      [first.ing, second.ing].join(" and ")
    elsif self.match(" or ")
      first, second = self.split(' or ', 2)
      [first.ing, second.ing].join(" or ")
    elsif self.match("/")
      first, second = self.split('/', 2)
      [first.ing, second.ing].join("/")
    elsif self.match(" ")
      first, second = self.split(' ', 2)
      [first.ing, second].join(" ")
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

  def has; plural? ? "have" : "has"; end
  alias have :has
  def was; plural? ? "were" : "was"; end
  alias were :was
  def does; plural? ? "do" : "does"; end
  alias do :does

end
