# Restart required even in development mode when you modify this file.

# A list of all the methods defined here to prevent breaking rails by overwriting something in use
MINE = %w{chip squash second third fourth without uncapitalize  split_camelcased invert_case phrase? camelcased? words first_word second_word last_word last_words first_words to_wbr prefix suffix slot slide wrap unwrap is_tls? to_fa is_mbti? mbti_index mbti_row dominant switch auxiliary jungian s ed en ing an too_much too_little compound_verb? compounded more even_more enough plural? fewer less little few much many as_much as_many that those is are them it they has have was were does do}

MINE.each do |meth|
 raise "#{meth} is already defined in String class" if String.method_defined?(meth)
end

class String

  def chip; self[1..-1]; end
  def squash; self.gsub(/\s/, ''); end
  def second; chars.second; end
  def third; chars.third; end
  def fourth; chars.fourth; end

  def without(excluded); [self.chars - excluded.chars].join; end

  def uncapitalize; self[0] = self[0].downcase; self; end
  def split_camelcased; self.split('<wbr>'); end
  def invert_case; split_camelcased.map(&:upcase).map(&:uncapitalize).join('<wbr>') ; end

  def phrase?; self.match(' '); end
  def camelcased?; underscore.match('_'); end

  def words
    if phrase?
      split
    elsif self.camelcased?
      split_camelcased
    else
      [self]
    end
  end

  def first_word; words.first; end
  def second_word; words.second; end
  def last_word; words.last; end
  def last_words; words.drop(1).to_phrase; end
  def first_words; words.clip.to_phrase; end

  def to_wbr; words.map(&:titleize).join('<wbr>'); end

  def prefix(word); [word, *words].to_phrase; end
  def suffix(word); [*words, word].to_phrase; end

  def slot(word) #slot me in after the word
    new_words = words.size == 1 ? [word,self] : words.insert(1,word)
    camelcased? ? new_words.join : new_words.to_phrase
  end

  def slide(word) #slide me in before the word
    new_words = words.size == 1 ? [self,word] : words.insert(1,word)
    camelcased? ? new_words.join : new_words.to_phrase
  end

  def wrap(*ary)
     case ary.size
     when 0
       before, after = '(', ')'
     when 1
       before, after = ary*2
     when 2
       before, after = ary
     else
       raise 'sorry, must have 0, 1, or 2 arguments'
     end
     "#{before}#{self}#{after}"
  end

  def unwrap; chip.chop; end

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
    raise 'can only be called on MBTI types' unless is_mbti?
    mbti_row.even? ? chars.values_at(0,1,3).join : chars.values_at(0,2,3).join
  end

  def switch(a, b); self.gsub(a, 'x').gsub(b, a).gsub('x', b); end

  def auxiliary
    raise 'can only be called on MBTI types' unless is_mbti?
    verted = self.switch('E', 'I')
    mbti_row.even? ? verted.chars.values_at(0,2,3).join : verted.chars.values_at(0,1,3).join
  end

  def jungian; [dominant, auxiliary].map(&:to_fa).join; end


  def s
    return 'watches' if self=='watch'
    return 'buys' if self=='buy'
    return 'says' if self=='say'
    return 'does' if self=='do'
    return 'goes' if self=='go'
    if phrase?
      [first_word.s, last_words].to_phrase
    elsif self.match('/')
      first, second = self.split('/', 2)
      [first.s, second.s].join('/')
    else
      self.sub(/e?y$/, 'ie').sub(/ax/, 'axe') + 's'
    end
  end
  def ed
    return 'sat' if self=='sit'
    return 'went' if self=='go'
    return 'fed' if self=='feed'
    return 'ate' if self=='eat'
    return 'forgot' if self=='forget'
    return 'left' if self=='leave'
    return 'sold' if self=='sell'
    return 'felt' if self=='feel'
    return 'bought' if self=='buy'
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
    return 'wrote' if self=='write'
    return 'read' if self=='read'
    return 'got' if self=='get'
    return 'knew' if self=='know'
    if phrase?
      [first_word.ed, last_words].to_phrase
    else
      self.sub(/e$/, '').sub(/ty$/, 'ti') + 'ed'
    end
  end

  def en
    return 'shown' if self=='show'
    return 'eaten' if self=='eat'
    return 'forgotten' if self=='forget'
    return 'done' if self=='do'
    return 'run' if self=='run'
    return 'seen' if self=='see'
    return 'paid' if self=='pay'
    return 'said' if self=='say'
    return 'gone' if self=='go'
    return 'spoken' if self=='speak'
    return 'gotten' if self=='get'
    return 'known' if self=='knew'
    if phrase?
      [first_word.en, last_words].to_phrase
    else
      self.ed
    end
  end

  def ly; self.sub(/y$/, 'i') + 'ly'; end

  def ing
    return 'hardening' if self=='harden'
    return 'lying' if self=='lie'
    return 'listening' if self=='listen'
    return 'abandoning' if self=='abandon'
    return 'quitting' if self=='quit'
    return 'visiting' if self=='visit'
    return 'positing' if self=='posit'
    return 'developing' if self=='develop'
    return 'overdeveloping' if self=='overdevelop'
    return 'panicking' if self=='panic'
    if self.match(' and ')
      first, second = self.split(' and ', 2)
      [first.ing, second.ing].join(' and ')
    elsif self.match(' or ')
      first, second = self.split(' or ', 2)
      [first.ing, second.ing].join(' or ')
    elsif self.match('/')
      first, second = self.split('/', 2)
      [first.ing, second.ing].join('/')
    elsif self.match(' \(')
      first, second = self.split(' (', 2)
      [first.ing, second.chop.ing].join(' (') + ')'
    elsif phrase?
      [first_word.ing, last_words].to_phrase
    else
      self.sub(/([^aeiou])([aeiou])([bpntg])$/, '\1\2\3\3').sub(/([^e])e$/, '\1') + 'ing'
    end
  end

  def an
    %w{a e i o u}.include?(self.first.downcase) ? "an #{self}" : "a #{self}"
  end

  def too_much
    if self.match(' ')
      first, second = self.split(' ', 2)
      [first, 'too', second.much, second].to_phrase
    else
      "#{self} too much"
    end
  end
  def too_little
    if self.match(' ')
      first, second = self.split(' ', 2)
      [first, 'too', second.little, second].to_phrase
    else
      "#{self} too little"
    end
  end

  def compound_verb?
    return true if self.match(/^listen to/)
    return true if self.match(/^look at/)
    return false
  end

  def compounded(word)
    if compound_verb?
      [first_words, word, last_word].to_phrase
    elsif phrase?
      slot(word)
    else
      slide(word)
    end
  end

  def more; compounded('more'); end
  def even_more; compounded('even more'); end
  def enough; compounded('enough'); end

  def plural?
    return false if self == 'guess'
    return true if self == 'people'
    return true if self[-1] == 's'
    return false
  end

  def fewer
    f_or_l = plural? ? 'fewer' : 'less'
    if compound_verb?
      [first_words, f_or_l, last_word].to_phrase
    elsif phrase?
      [first_word, f_or_l, last_words].to_phrase
    elsif plural?
      slot('fewer')
    else
      slide('less')
    end
  end
  alias less :fewer

  def as_much
    as = plural? ? 'as many' : 'as much'
    if compound_verb?
      [first_words, as, last_word].to_phrase
    elsif phrase?
      slot(as)
    else
      slide(as)
    end
  end
  alias as_many :as_much

  def a_lot
    if phrase?
      [first_word, 'a lot of', last_words].to_phrase
    else
      "#{self} a lot"
    end
  end

  def little; plural? ? prefix('few') : prefix('little'); end
  alias few :little
  def much; plural? ? suffix('many') : suffix('much'); end
  alias many :much
  def that; plural? ? prefix('those') : prefix('that'); end
  alias those :that
  def is; plural? ? suffix('are') : suffix('is'); end
  alias are :is
  def them; plural? ? suffix('them') : suffix('it'); end
  alias it :them
  def they; plural? ? prefix('they') : prefix('it'); end
  def has; plural? ? suffix('have') : suffix('has'); end
  alias have :has
  def was; plural? ? suffix('were') : suffix('was'); end
  alias were :was
  def does; plural? ? suffix('do') : suffix('does'); end
  alias do :does

end
