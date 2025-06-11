# Restart required even in development mode when you modify this file.

# A list of all the methods defined here to prevent breaking rails by overwriting something in use
%w{chip second third fourth words clean to_wbr first_words last_words first_word last_word quote dquote sqwrap parenthesize wrap end_wrap start_wrap unwrap wrapped? comma period semi colon bang break punctuated? unpunctuate make_mine and_to_or is_mbti? capitalized? to_noun s ed en ly ing an some a_lot a_lot_of enough enough_of many too_many too_much too_few too_little a_few plural? uncountable? little few more fewer less much as_much many as_many not_always that those is are was were them it they able un begins_with? has have do does}.each do |meth|
 raise "#{meth} is already defined in String class" if String.method_defined?(meth)
end

class String

  def chip; self[1..-1]; end
  def second; chars.second; end
  def third; chars.third; end
  def fourth; chars.fourth; end
  def words; self.match(' ') ? split(/\s+/) : split('/'); end
  def clean; self.gsub('_', ' ').gsub('<wbr>', '').gsub('your self', 'yourself').gsub(/^do not/, 'don’t').gsub('not not', '').gsub(' to do ', ' to ').gsub(' to don’t ', ' to not ').gsub('not do ', 'don’t '); end
  def make_mine(be='am'); words.replace_with('your', 'my').replace_with('be', be).to_phrase; end
  def to_wbr; self.words.map(&:capitalize).wbr; end

  # these assume the string is three words
  # 'listen to music' has the preposition to, and gets split as 'listen to' and 'music'
  # 'eat sweet foods' has the adjective sweet', and gets plits as 'eat' and 'sweet foods'
  PREPS = %w{after at before from for of off on over to with the a an} # articles aren't prepositions, but are split the same
  def prep?; PREPS.include?(words[1]); end
  def first_words
    case words.count
    when 1,2
      words.first
    when 3
      prep? ? words.first(2).to_phrase : words.first
    else
      words.count.even? ?
      words.first(words.count/2).to_phrase :
      words.first((words.count+1)/2).to_phrase
    end
  end
  alias first_word :first_words
  def last_words
    case words.count
    when 1
      ''
    when 2
      words.last
    when 3
      prep? ? words.last : words.last(2).to_phrase
    else
      words.count.even? ?
      words.last(2).to_phrase :
      words.first((words.count-1)/2).to_phrase
    end
  end
  alias last_word :last_words

  def quote; "‘#{self}’"; end
  def dquote; "“#{self}”"; end
  def sqwrap; "[#{self}]"; end
  def parenthesize; "(#{self})"; end
  alias wrap :parenthesize
  def end_wrap; "#{self})"; end
  def start_wrap; "(#{self}"; end
  def wrapped?; self.last == ')' && self[0] == '('; end
  def unwrap
    if wrapped?
      if self[0] == '('
        self.chop.chip
      else
        self.chop
      end
    else
      return self
    end
  end
  def comma; self + ','; end
  def period; self + '.'; end
  def semi; self + ';'; end
  def colon; self + ':'; end
  def bang; self + '!'; end
  def question; self + '?'; end
  def break; self + '<br />'; end

  PUNCTUATIONS = %w{, . ; : !}
  def punctuated?; PUNCTUATIONS.include?(self.last); end
  def unpunctuate
    if punctuated?
      self.chop.unpunctuate
    else
      return self
    end
  end

  def and_to_or; self.gsub(' and ', ' or '); end
  def break_before_wrap; gsub(' (', '<br />(').html_safe; end

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

  NOUNS = %w{anorexia depression mania energy strength obesity
    goals emptiness hyperactivity weakness calories credit
    information emotions childhood adolescence adulthood old\ age
    child adolescent adult elder curiosity agitation appetite anxiety irritation boredom}
  ADJECTIVES = %w{anorexic depressed manic energetic strong obese
    goal-oriented empty hyperactive weak caloric indebted
    informative emotional child adolescent adult elder
    childish adolescent mature wise curious agitated appetitive anxious irritable bored}
  def noun?; NOUNS.include?(self); end


  def capitalized?; self.first != self.first.downcase; end
  def to_noun
    index = ADJECTIVES.index(self.downcase)
    noun = index ? NOUNS[index] : "#{self.an} #{self} person"
    capitalized? ? noun.capitalize : noun
  end

  def to_adjective
    index = NOUNS.index(self)
    adj = index ? ADJECTIVES[index] : "#{self}-like"
    capitalized? ? adj.capitalize : adj
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
      [first_words.s, last_words].join(' ')
    elsif self.match('/')
      first, second = self.split('/', 2)
      [first.s, second.s].join('/')
    else
      self.sub(/ss$/, 'sse').sub(/e?y$/, 'ie') + 's'
    end
  end
  def ed
    return 'bought' if self=='buy'
    return 'quit' if self=='quit'
    return 'fled' if self=='flee'
    return 'won' if self=='win'
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
    return 'rebuilt' if self=='rebuild'
    return 'spoke' if self=='speak'
    if self.match(' ')
      if last_words.wrapped?
        return [first_words.ed, last_words.unwrap.ed.wrap].to_phrase
      else
        return [first_words.ed, last_words].to_phrase
      end
    else
      self.sub(/e$/, '').sub(/y$/, 'i') + 'ed'
    end
  end

  def en
    return 'taken' if self=='take'
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
      if last_words.wrapped?
        [first_words.en, last_words.unwrap.en.wrap].to_phrase
      else
        [first_words.en, last_words].to_phrase
      end
   else
      self.ed
    end
  end

  def ly
    return '' if self.blank?
    if self.match(': ')
      return [first_words, last_words.ly].join(' ')
    elsif self.match(' ')
      return [first_words.ly, last_words].join(' ')
    end
    self.gsub(/ic$/, 'ical').gsub(/y$/,'i').gsub(/le$/,'') + 'ly'
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
    if self.starts_with?('not ')
      return [first_words, last_words.ing].to_phrase
    end
    [' and ', ' or ', '/', ' & '].each do |connector|
      if self.match(connector)
        first, second = self.split(connector, 2)
        return [first.ing, second.ing].join(connector)
      end
    end
    if self.punctuated?
      return self.chop.ing + self.last
    end
    if self.match(' ')
      if last_words.wrapped?
        return [first_words.ing, last_words.unwrap.ing.wrap].to_phrase
      else
        return [first_words.ing, last_words].to_phrase
      end
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
    [' a ', ' the ',].each do |connector|
      if self.match(connector)
        first, second = self.split(connector, 2)
        return [first, 'enough of', connector, second].to_phrase
      end
    end
    if self.match(' ')
      [first_words, 'enough', last_words].join(' ')
    elsif self.noun?
      "enough #{self}"
    else
      "#{self} enough"
    end
  end
  def an
    first =  %w{a e i o u}.include?(self.first.downcase) ? 'an' : 'a'
    capitalized? ? "#{first.capitalized} #{self.downcase}" : "#{first} #{self}"
  end
  def some
    if self.match(' ')
      [first_words, 'some', last_words].join(' ')
    else
      "#{self} some"
    end
  end
  def a_lot
    if self.match(' ')
      [first_words, last_words.many, last_words].join(' ')
    else
      "#{self} a lot"
    end
  end
  def a_lot_of
    if self.match(' ')
      [first_words, 'a lot of', last_words].join(' ')
    else
      "a lot of #{self}"
    end
  end
  def a_few
    if self.match(' ')
      [first_words, 'a', last_words.few, last_words].join(' ')
    else
      "#{self} a little"
    end
  end
  def too_much
    if self.match('(.*) a (.*)')
      if $2.uncountable?
        return [$1, 'too much', $2].to_phrase
      else
        return [$1, 'too many', $2.pluralize].to_phrase
      end
    end
    [' and ', ' or ', ' / ', ' & '].each do |connector|
      if self.match(connector)
        first, second = self.split(connector, 2)
        return [first.too_much, second.too_much].join(connector)
      end
    end
    if self.match(' ')
      [first_words, 'too', last_words.much, last_words].join(' ')
    elsif self.noun?
      "too #{self.many} #{self}"
    else
      "#{self} too much"
    end
  end
  alias too_many :too_much
  def too_little
    if self.match(' ')
      [first_words, 'too', last_words.little, last_words].join(' ')
    else
      "#{self} too little"
    end
  end
  alias too_few :too_little

  def more
    if self.match('(.*) a (.*)')
      [$1, 'more of a', $2].to_phrase
    elsif self.match(' ')
      if last_words.words.first == 'good'
        [first_words, 'better', last_words.delete_prefix('good')].to_phrase
      else
        [first_words, 'more', last_words].to_phrase
      end
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
      [first_words, 'any more', last_words].join(' ')
    else
      "#{self} any more"
    end
  end

  def as_much
    if self.match(' ')
      [first_words, 'as', last_words.much, last_words].join(' ')
    else
      "#{self} as much"
    end
  end
  alias as_many :as_much
  def so_much
    if self.match(' ')
      [first_words, 'so', last_words.much, last_words].join(' ')
    elsif self.noun?
      "so #{self.much} #{self}"
    else
      "#{self} so much"
    end
  end
  alias so_many :so_much

  def as_few
    if self.match(' ')
      [first_words, 'as', last_words.few, last_words].join(' ')
    else
      "#{self} as little"
    end
  end

  def plural?
    return unwrap.plural? if wrapped?
    return true if self == 'people'
    return true if first_words[-1] == 's'
    return true if self.match(/. things/)
    return false
  end

  def uncountable?
    return unwrap.uncountable? if wrapped?
    return true if self == 'salary'
    return false
  end

  def few; plural? ? 'few' : 'little'; end
  def fewer; plural? ? 'fewer' : 'less'; end
  def less
    if self.match(' ')
      [first_words, last_words.fewer, last_words].join(' ')
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
