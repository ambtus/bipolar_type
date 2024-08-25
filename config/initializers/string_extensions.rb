# Restart required even in development mode when you modify this file.

# A list of all the methods defined here to prevent breaking rails by overwriting something in use
%w{chip second third fourth words clean n first_word last_words last_word parenthesize wrap comma period semi colon replace_and_with_or is_mbti? to_noun s ed en ly ing an some enough many too_many too_much too_few too_little a_few plural? little few more fewer less much as_much many as_many that those is are was were them it they able un begins_with? has have do does}.each do |meth|
 raise "#{meth} is already defined in String class" if String.method_defined?(meth)
end

class String

  def chip; self[1..-1]; end
  def second; chars.second; end
  def third; chars.third; end
  def fourth; chars.fourth; end
  def words; split(/\s+/); end
  def clean; self.gsub('_', ' ').gsub('<wbr>', '').gsub('your self', 'yourself'); end
  def to_words; self.underscore.to_phrase.words; end

  def n; words.size - 1;end
  def first_word; words.first; end
  def last_word; words.last; end
  def first_words; words.first(n).to_phrase; end
  def last_words; words.last(n).to_phrase; end
  def parenthesize; "(#{self})"; end
  alias wrap :parenthesize
  def comma; self + ','; end
  def period; self + '.'; end
  def semi; self + ';'; end
  def colon; self + ':'; end

  def replace_and_with_or; self.gsub(' and ', ' or '); end

  MBTIS = %w{ISTP ISFP INTP INFP
             ISTJ ISFJ INTJ INFJ
             ESTP ESFP ENTP ENFP
             ESTJ ESFJ ENTJ ENFJ}
  def is_mbti?; MBTIS.include? self; end

  def dominant
    return self.chars.values_at(0,2,3).join if (self.match(/I..P/) || self.match(/E..J/))
    return self.chars.values_at(0,1,3).join if (self.match(/I..J/) || self.match(/E..P/))
  end
  def auxiliary
    if self.match(/I..P/)
      ['E', chars[1], 'P'].join
    elsif self.match(/I..J/)
      ['E', chars[2], 'J'].join
    elsif self.match(/E..P/)
      ['I', chars[2], 'P'].join
    elsif self.match(/E..J/)
      ['I', chars[1], 'J'].join
    end
  end

  NOUNS = %w{anorexia depression mania energy strength obesity goals emptiness hyperactivity weakness calories credit information emotions}
  ADJECTIVES = %w{anorexic depressed manic energetic strong obese goal-oriented empty hyperactive weak caloric indebted informative emotional}
  def noun?; NOUNS.include?(self); end


  def to_noun
    index = ADJECTIVES.index(self)
    index ? NOUNS[index] : "#{self.an} #{self} person"
  end

  def to_adjective
    index = NOUNS.index(self)
    index ? ADJECTIVES[index] : "#{self}-like"
  end

  def s
    return 'watches' if self=='watch'
    return 'buys' if self=='buy'
    return 'pays' if self=='pay'
    return 'says' if self=='say'
    return 'does' if self=='do'
    return 'goes' if self=='go'
    return 'relaxes' if self=='relax'
    if self.match(' or ')
      first, second = self.split(' or ', 2)
      [first.s, second.s].join(' or ')
    elsif self.match(' ')
      [first_word.s, last_words].join(' ')
    elsif self.match('/')
      first, second = self.split('/', 2)
      [first.s, second.s].join('/')
    else
      self.sub(/ss$/, 'sse').sub(/e?y$/, 'ie') + 's'
    end
  end
  def ed
    return 'got' if self=='get'
    return 'sang' if self=='sing'
    return 'paid' if self=='pay'
    return 'sat' if self=='sit'
    return 'went' if self=='go'
    return 'fed' if self=='feed'
    return 'ate' if self=='eat'
    return 'forgot' if self=='forget'
    return 'left' if self=='leave'
    return 'sold' if self=='sell'
    return 'felt' if self=='feel'
    return 'thought' if self=='think'
    return 'told' if self=='tell'
    return 'spent' if self=='spend'
    return 'made' if self=='make'
    return 'heard' if self=='hear'
    return 'did' if self=='do'
    return 'fought' if self=='fight'
    return 'ran' if self=='run'
    return 'hit' if self=='hit'
    return 'saw' if self=='see'
    return 'shopped' if self=='shop'
    return 'planned' if self=='plan'
    return 'understood' if self=='understand'
    return 'lost' if self=='lose'
    return 'held' if self=='hold'
    return 'built' if self=='build'
    return 'spoke' if self=='speak'
    if self.match(' ')
      [first_word.ed, last_words].join(' ')
    else
      self.sub(/e$/, '').sub(/y$/, 'i') + 'ed'
    end
  end

  def en
    return 'gotten' if self=='get'
    return 'shown' if self=='show'
    return 'sung' if self=='sing'
    return 'eaten' if self=='eat'
    return 'forgotten' if self=='forget'
    return 'done' if self=='do'
    return 'run' if self=='run'
    return 'seen' if self=='see'
    return 'gone' if self=='go'
    return 'spoken' if self=='speak'
    if self.match(' ')
      [first_word.en, last_words].join(' ')
    else
      self.ed
    end
  end

  def ly
    return '' if self.blank?
    if self.match(': ')
      return [first_word, last_words.ly].join(' ')
    elsif self.match(' ')
      return [first_word.ly, last_words].join(' ')
    end
    self.gsub(/le$/,'') + 'ly'
  end

  def able
      return 'comprehensible' if self == 'comprehend'
      self.sub(/e$/, '') + 'able'
  end

  def un
    return 'incomprehensible' if self == 'comprehensible'
    "un#{self}"
  end

  def ing
    return 'eating' if self == 'eat'
    return 'hardening' if self=='harden'
    return 'lying' if self=='lie'
    return 'listening' if self=='listen'
    return 'abandoning' if self=='abandon'
    return 'quitting' if self=='quit'
    return 'visiting' if self=='visit'
    return 'positing' if self=='posit'
    return 'developing' if self=='develop'
    return 'panicking' if self=='panic'
    return 'reasoning' if self=='reason'
    return 'gardening' if self=='garden'
    [' and ', ' or ', '/', ' & '].each do |connector|
      if self.match(connector)
        first, second = self.split(connector, 2)
        return [first.ing, second.ing].join(connector)
      end
    end
    if self.match(' ')
      return [first_word.ing, last_words].join(' ')
    end
    self.sub(/([^aeiou])([aeiou])([bpntg])$/, '\1\2\3\3').sub(/([^e])e$/, '\1') + 'ing'
  end

  def enough
    [' and ', ' or ', '/', ' & '].each do |connector|
      if self.match(connector)
        first, second = self.split(connector, 2)
        return [first.enough, second.enough].join(connector)
      end
    end
    if self.match(' ')
      [first_words, 'enough', last_word].join(' ')
    elsif self.noun?
      "enough #{self}"
    else
      "#{self} enough"
    end
  end
  def an
    %w{a e i o u}.include?(self.first) ? 'an' : 'a'
  end
  def some
    if self.match(' ')
      [first_word, 'some', last_words].join(' ')
    else
      "#{self} some"
    end
  end
  def a_lot
    if self.match(' ')
      [first_words, last_word.many, second].join(' ')
    else
      "#{self} a lot"
    end
  end
  def a_few
    if self.match(' ')
      [first_words, 'a', last_word.few, last_word].join(' ')
    else
      "#{self} a little"
    end
  end
  def too_much
    [' and ', ' or ', '/', ' & '].each do |connector|
      if self.match(connector)
        first, second = self.split(connector, 2)
        return [first.too_much, second.too_much].join(connector)
      end
    end
    if self.match(' ')
      [first_words, 'too', last_word.much, last_word].join(' ')
    elsif self.noun?
      "too #{self.many} #{self}"
    else
      "#{self} too much"
    end
  end
  alias too_many :too_much
  def too_little
    if self.match(' ')
      [first_words, 'too', last_word.little, last_word].join(' ')
    else
      "#{self} too little"
    end
  end
  alias too_few :too_little

  def more
    if self.match(' ')
      [first_words, 'more', last_word].join(' ')
    elsif self.noun?
      "more #{self}"
    else
      "#{self} more"
    end
  end
  def any_more
    if self.match(' the ')
      self.gsub('the', 'any more')
    elsif self.match(' ')
      [first_words, 'any more', last_word].join(' ')
    else
      "#{self} any more"
    end
  end

  def as_much
    if self.match(' ')
      [first_words, 'as', last_word.much, last_word].join(' ')
    else
      "#{self} as much"
    end
  end
  alias as_many :as_much
  def so_much
    if self.match(' ')
      [first_words, 'so', last_word.much, last_word].join(' ')
    elsif self.noun?
      "so #{self.much} #{self}"
    else
      "#{self} so much"
    end
  end
  alias so_many :so_much

  def plural?
    return true if self == 'people'
    return true if first_word[-1] == 's'
    return false
  end

  def fewer; plural? ? 'fewer' : 'less'; end
  def less
    if self.match(' ')
      [first_words, last_word.fewer, last_word].join(' ')
    else
      "#{self} less"
    end
  end




  def begins_with?(string); self.match(/\A#{string}/); end

  def little; plural? ? 'few' : 'little'; end
  alias few :little
  def much; plural? ? 'many' : 'much'; end
  alias many :much
  def that; plural? ? 'those' : 'that'; end
  alias those :that
  def is; plural? ? "#{self} are": "#{self} is"; end
  alias are :is
  def them; plural? ? 'them' : 'it'; end
  alias it :them
  def they; plural? ? 'they' : 'it'; end

  def has; plural? ? 'have' : 'has'; end
  alias have :has
  def was; plural? ? 'were' : 'was'; end
  alias were :was
  def does; plural? ? 'do' : 'does'; end
  alias do :does

end
