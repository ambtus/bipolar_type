# Restart required even in development mode when you modify this file.

# A list of all the methods defined here to prevent breaking rails by overwriting something in use
MINE = %w{chip squash second third fourth words first_word last_words last_word wrap is_tls? to_fa is_mbti? mbti_index mbti_row dominant switch auxiliary jungian s ed en ly ing enough an some a_lot a_few many too_much too_little  plural? little few fewer less more much many that those is are them it they has have was were does do}

MINE.each do |meth|
 raise "#{meth} is already defined in String class" if String.method_defined?(meth)
end

class String

  def chip; self[1..-1]; end
  def squash; self.gsub(/\s/, ''); end
  def second; chars.second; end
  def third; chars.third; end
  def fourth; chars.fourth; end
  def words; split; end

  def first_word; words.first; end
  def last_word; words.last; end
  def last_words; words.drop(1).to_phrase; end

  def wrap(*ary)
     case ary.size
     when 0
       before, after = '(', ')'
     when 1
       before, after = ary*2
     when 2
       before, after = ary
     else
       raise "sorry, must have 0, 1, or 2 arguments"
     end
     "#{before}#{self}#{after}"
  end

  TLS = %w{
           ESP ENP
           ITP IFP
           ISJ INJ
           ETJ EFJ
          }
  def is_tls?; TLS.include?(self); end

  FA = %w{Se Ne Ti Fi Si Ni Te Fe} # function-attitudes

  def to_fa
    raise "can only be called on one of #{TLS}" unless is_tls?
    FA[TLS.index(self)]
  end

  MBTI = %w{
             ESTP ESFP ENTP ENFP
             ISTP ISFP INTP INFP
             ISTJ ISFJ INTJ INFJ
             ESTJ ESFJ ENTJ ENFJ
            }

  def is_mbti?; MBTI.include?(self); end
  def mbti_index; is_mbti? && MBTI.index(self); end
  def mbti_row; mbti_index/4; end

  def dominant
    raise "can only be called on MBTI types" unless is_mbti?
    mbti_row.even? ? chars.values_at(0,1,3).join : chars.values_at(0,2,3).join
  end

  def switch(a, b); self.gsub(a, "x").gsub(b, a).gsub('x', b); end

  def auxiliary
    raise "can only be called on MBTI types" unless is_mbti?
    verted = self.switch('E', 'I')
    mbti_row.even? ? verted.chars.values_at(0,2,3).join : verted.chars.values_at(0,1,3).join
  end

  def jungian; [dominant, auxiliary].map(&:to_fa).join; end


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
    return "wrote" if self=="write"
    return "read" if self=="read"
    return "got" if self=="get"
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
    return "gotten" if self=="get"
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
