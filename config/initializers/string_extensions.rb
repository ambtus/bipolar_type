# frozen_string_literal: true

# Restart required even in development mode when you modify this file.

# A list of all the methods defined here to prevent breaking rails by overwriting something in use
%w[chip second third fourth words clean to_wbr first_words last_words first_word last_word
   quote dquote sqwrap parenthesize deunderscore wrap end_wrap endwrap start_wrap unwrap
   wrapped? comma period semi colon bang break punctuated? unpunctuate make_mine
   make_yours make_theirs and_to_or is_mbti? capitalized? to_noun to_adjective s ed en er
   ly ing an some a_lot a_lot_of enough enough_of many too_many too_much too_few
   too_little a_few plural? uncountable? little few more fewer less much as_much many
   as_many not_always that those is are was were them it they able un begins_with? has
   have do does].each do |meth|
  raise "#{meth} is already defined in String class" if String.method_defined?(meth)
end

class String
  def chip = self.[](1..)
  delegate :second, to: :chars
  delegate :third, to: :chars
  delegate :fourth, to: :chars
  def words = match?(' ') ? split(/\s+/) : split('/')

  def clean
    tr('_', ' ').gsub('<wbr>', '').gsub('your self', 'yourself')
                .gsub(/^do not/, 'don’t').gsub('not not', '').gsub(' to do ', ' to ')
                .gsub(' to don’t ', ' to not ')
                .gsub('not do ', 'don’t ')
  end

  def make_mine(be = 'am') = words.replace_with('your', 'my').replace_with('be', be).to_phrase
  def make_yours(are = 'are') = words.replace_with('my', 'your').replace_with('are', are).to_phrase
  def make_theirs = words.replace_with('your', 'their').to_phrase
  def to_wbr = words.map(&:capitalize).wbr

  # these assume the string is three words
  # 'listen to music' has the preposition to, and gets split as 'listen to' and 'music'
  # 'eat sweet foods' has the adjective sweet', and gets plits as 'eat' and 'sweet foods'
  # articles aren't prepositions, but are split the same
  PREPS = %w[after at before from for of off on over to with the a an].freeze
  def prep? = PREPS.include?(words[1])

  def first_words
    case words.count
    when 1, 2
      words.first
    when 3
      prep? ? words.first(2).to_phrase : words.first
    else
      if words.count.even?
        words.first(words.count / 2).to_phrase
      else
        words.first((words.count + 1) / 2).to_phrase
      end
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
      if words.count.even?
        words.last(2).to_phrase
      else
        words.first((words.count - 1) / 2).to_phrase
      end
    end
  end
  alias last_word :last_words

  def quote = "‘#{self}’"
  def dquote = "“#{self}”"
  def sqwrap = "[#{self}]"
  def parenthesize = "(#{self})"
  alias wrap :parenthesize
  def end_wrap = "#{self})"
  alias :endwrap end_wrap
  def start_wrap = "(#{self}"
  def wrapped? = last == ')' && self[0] == '('

  def unwrap
    return self unless wrapped?

    if self[0] == '('
      chop.chip
    else
      chop
    end
  end

  def deunderscore = tr('_', ' ')
  def comma = "#{self},"
  def period = "#{self}."
  def semi = "#{self};"
  def colon = "#{self}:"
  def bang = "#{self}!"
  def question = "#{self}?"
  def break = "#{self}<br />"

  PUNCTUATIONS = %w[, . ; : !].freeze
  def punctuated? = PUNCTUATIONS.include?(last)

  def unpunctuate
    return self unless punctuated?

    chop.unpunctuate
  end

  def and_to_or = gsub(' and ', ' or ')
  def break_before_wrap = gsub(' (', '<br />(').html_safe

  MBTIS = %w[ISTP ISFP INTP INFP
             ISTJ ISFJ INTJ INFJ
             ESTP ESFP ENTP ENFP
             ESTJ ESFJ ENTJ ENFJ].freeze
  def is_mbti? = MBTIS.include?(self)

  def dominant
    return chars.values_at(0, 2, 3).join if match(/I..P/) || match(/E..J/)

    chars.values_at(0, 1, 3).join if match(/I..J/) || match(/E..P/)
  end

  def auxiliary
    case self
    when /I..P/
      ['E', chars[1], 'P'].join
    when /I..J/
      ['E', chars[2], 'J'].join
    when /E..P/
      ['I', chars[2], 'P'].join
    when /E..J/
      ['I', chars[1], 'J'].join
    end
  end

  NOUNS = %w[anorexia depression mania energy strength obesity goals
             emptiness hyperactivity weakness calories credit information
             emotions childhood adolescence adulthood old age child
             adolescent adult elder curiosity agitation appetite lazy
             anxiety irritation boredom anger fear exhaustion lethargy
             hunger].freeze
  ADJECTIVES = %w[anorexic depressed manic energetic strong obese goal-oriented
                  empty hyperactive weak caloric indebted informative
                  emotional child adolescent adult elder childish
                  adolescent mature wise curious agitated ?? ??
                  anxious irritable bored angry afraid tired lethargic
                  hungry ].freeze

  def noun? = NOUNS.include?(self)
  def capitalized? = first != first.downcase

  def to_noun
    index = ADJECTIVES.index(downcase)
    noun = index ? NOUNS[index] : "#{an} #{self} person"
    capitalized? ? noun.capitalize : noun
  end

  def to_adjective
    index = NOUNS.index(self)
    adj = index ? ADJECTIVES[index] : "#{self}-like"
    capitalized? ? adj.capitalize : adj
  end

  def s
    return 'watches' if self == 'watch'
    return 'buys' if self == 'buy'
    return 'pays' if self == 'pay'
    return 'says' if self == 'say'
    return 'does' if self == 'do'
    return 'goes' if self == 'go'
    return 'relaxes' if self == 'relax'

    if match?(' or ')
      first, second = split(' or ', 2)
      [first.s, second.s].join(' or ')
    elsif match?(' ')
      [first_words.s, last_words].join(' ')
    elsif match?('/')
      first, second = split('/', 2)
      [first.s, second.s].join('/')
    else
      "#{sub(/ss$/, 'sse').sub(/e?y$/, 'ie')}s"
    end
  end

  def ed
    return 'sought' if self == 'seek'
    return 'chose' if self == 'choose'
    return 'bought' if self == 'buy'
    return 'quit' if self == 'quit'
    return 'fled' if self == 'flee'
    return 'won' if self == 'win'
    return 'got' if self == 'get'
    return 'sang' if self == 'sing'
    return 'paid' if self == 'pay'
    return 'sat' if self == 'sit'
    return 'went' if self == 'go'
    return 'fed' if self == 'feed'
    return 'ate' if self == 'eat'
    return 'forgot' if self == 'forget'
    return 'left' if self == 'leave'
    return 'sold' if self == 'sell'
    return 'felt' if self == 'feel'
    return 'thought' if self == 'think'
    return 'told' if self == 'tell'
    return 'spent' if self == 'spend'
    return 'made' if self == 'make'
    return 'heard' if self == 'hear'
    return 'did' if self == 'do'
    return 'fought' if self == 'fight'
    return 'ran' if self == 'run'
    return 'hit' if self == 'hit'
    return 'saw' if self == 'see'
    return 'shopped' if self == 'shop'
    return 'planned' if self == 'plan'
    return 'understood' if self == 'understand'
    return 'lost' if self == 'lose'
    return 'held' if self == 'hold'
    return 'built' if self == 'build'
    return 'rebuilt' if self == 'rebuild'
    return 'spoke' if self == 'speak'
    return 'enjoyed' if self == 'enjoy'
    return 'prayed' if self == 'pray'

    if match?(' ')
      return [first_words.ed, last_words.unwrap.ed.wrap].to_phrase if last_words.wrapped?

      [first_words.ed, last_words].to_phrase

    else
      "#{sub(/e$/, '').sub(/y$/, 'i')}ed"
    end
  end

  def en
    return 'chosen' if self == 'choose'
    return 'taken' if self == 'take'
    return 'gotten' if self == 'get'
    return 'shown' if self == 'show'
    return 'sung' if self == 'sing'
    return 'eaten' if self == 'eat'
    return 'forgotten' if self == 'forget'
    return 'done' if self == 'do'
    return 'run' if self == 'run'
    return 'seen' if self == 'see'
    return 'gone' if self == 'go'
    return 'spoken' if self == 'speak'

    if match?(' ')
      if last_words.wrapped?
        [first_words.en, last_words.unwrap.en.wrap].to_phrase
      else
        [first_words.en, last_words].to_phrase
      end
    else
      ed
    end
  end

  def ly
    return '' if blank?
    if match?(': ')
      return [first_words, last_words.ly].join(' ')
    elsif match?(' ')
      return [first_words.ly, last_words].join(' ')
    end

    "#{gsub(/ic$/, 'ical').gsub(/y$/, 'i').gsub(/le$/, '')}ly"
  end

  def er
    "#{gsub(/y$/, 'i').gsub(/ad$/, 'add')}er"
  end

  def able
    return 'reliable' if self == 'rely on'
    return 'comprehensible' if self == 'comprehend'

    "#{sub(/e$/, '')}able"
  end

  def un
    return 'incomprehensible' if self == 'comprehensible'

    "un#{self}"
  end

  def ing
    return 'eating' if self == 'eat'
    return 'hardening' if self == 'harden'
    return 'lying' if self == 'lie'
    return 'listening' if self == 'listen'
    return 'abandoning' if self == 'abandon'
    return 'quitting' if self == 'quit'
    return 'visiting' if self == 'visit'
    return 'positing' if self == 'posit'
    return 'developing' if self == 'develop'
    return 'panicking' if self == 'panic'
    return 'reasoning' if self == 'reason'
    return 'gardening' if self == 'garden'
    return [first_words, last_words.ing].to_phrase if starts_with?('not ')

    [' and ', ' or ', '/', ' & '].each do |connector|
      if match(connector)
        first, second = split(connector, 2)
        return [first.ing, second.ing].join(connector)
      end
    end
    return chop.ing + last if punctuated?

    if match?(' ')
      return [first_words.ing, last_words.unwrap.ing.wrap].to_phrase if last_words.wrapped?

      return [first_words.ing, last_words].to_phrase

    end
    "#{sub(/([^aeiou])([aeiou])([bpntg])$/, '\1\2\3\3').sub(/([^e])e$/, '\1')}ing"
  end

  def enough
    [' and ', ' or ', '/', ' & '].each do |connector|
      if match(connector)
        first, second = split(connector, 2)
        return [first.enough, second.enough].join(connector)
      end
    end
    [' a ', ' the '].each do |connector|
      if match(connector)
        first, second = split(connector, 2)
        return [first, 'enough of', connector, second].to_phrase
      end
    end
    if match?(' ')
      [first_words, 'enough', last_words].join(' ')
    elsif noun?
      "enough #{self}"
    else
      "#{self} enough"
    end
  end

  def an
    first = %w[a e i o u].include?(self.first.downcase) ? 'an' : 'a'
    capitalized? ? "#{first.capitalized} #{downcase}" : "#{first} #{self}"
  end

  def some
    if match?(' ')
      [first_words, 'some', last_words].join(' ')
    else
      "#{self} some"
    end
  end

  def a_lot
    if match?(' ')
      [first_words, last_words.many, last_words].join(' ')
    else
      "#{self} a lot"
    end
  end

  def a_lot_of
    if match?(' ')
      [first_words, 'a lot of', last_words].join(' ')
    else
      "a lot of #{self}"
    end
  end

  def a_few
    if match?(' ')
      [first_words, 'a', last_words.few, last_words].join(' ')
    else
      "#{self} a little"
    end
  end

  def too_much
    if match('(.*) a (.*)')
      if ::Regexp.last_match(2).uncountable?
        return [::Regexp.last_match(1), 'too much',
                ::Regexp.last_match(2)].to_phrase
      end

      return [::Regexp.last_match(1), 'too many', ::Regexp.last_match(2).pluralize].to_phrase

    end
    [' and ', ' or ', ' / ', ' & '].each do |connector|
      if match(connector)
        first, second = split(connector, 2)
        return [first.too_much, second.too_much].join(connector)
      end
    end
    if match?(' ')
      [first_words, 'too', last_words.much, last_words].join(' ')
    elsif noun?
      "too #{many} #{self}"
    else
      "#{self} too much"
    end
  end
  alias too_many :too_much
  def too_little
    if match?(' ')
      [first_words, 'too', last_words.little, last_words].join(' ')
    else
      "#{self} too little"
    end
  end
  alias too_few :too_little

  def more
    if match('(.*) a (.*)')
      [::Regexp.last_match(1), 'more of a', ::Regexp.last_match(2)].to_phrase
    elsif match?(' ')
      if last_words.words.first == 'good'
        [first_words, 'better', last_words.delete_prefix('good')].to_phrase
      else
        [first_words, 'more', last_words].to_phrase
      end
    elsif noun?
      "more #{self}"
    else
      "#{self} more"
    end
  end

  def any_more
    if match?(' the ')
      gsub('the', 'any more')
    elsif match?(' ')
      [first_words, 'any more', last_words].join(' ')
    else
      "#{self} any more"
    end
  end

  def as_much
    if match?(' ')
      [first_words, 'as', last_words.much, last_words].join(' ')
    else
      "#{self} as much"
    end
  end
  alias as_many :as_much
  def so_much
    if match?(' ')
      [first_words, 'so', last_words.much, last_words].join(' ')
    elsif noun?
      "so #{much} #{self}"
    else
      "#{self} so much"
    end
  end
  alias so_many :so_much

  def as_few
    if match?(' ')
      [first_words, 'as', last_words.few, last_words].join(' ')
    else
      "#{self} as little"
    end
  end

  def plural?
    return unwrap.plural? if wrapped?
    return true if self == 'people'
    return true if first_words[-1] == 's'
    return true if /. things/.match?(self)

    false
  end

  def uncountable?
    return unwrap.uncountable? if wrapped?
    return true if self == 'salary'

    false
  end

  def little = plural? ? 'few' : 'little'
  alias few :little
  def fewer = plural? ? 'fewer' : 'less'

  def less
    if match?(' ')
      [first_words, last_words.fewer, last_words].join(' ')
    else
      "#{self} less"
    end
  end

  def begins_with?(string) = match(/\A#{string}/)

  def much = plural? ? 'many' : 'much'
  alias many :much
  def that = plural? ? 'those' : 'that'
  alias those :that
  def is = plural? ? "#{self} are" : "#{self} is"
  alias are :is
  def them = plural? ? 'them' : 'it'
  alias it :them
  def they = plural? ? 'they' : 'it'

  def has = plural? ? 'have' : 'has'
  alias have :has
  def was = plural? ? 'were' : 'was'
  alias were :was
  def does = plural? ? 'do' : 'does'
  alias do :does
end
