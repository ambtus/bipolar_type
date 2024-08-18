class Realm

  NAMES = %w{Physical Financial Affective Mental Generic}

  def initialize(name); @name = name; end
  attr_reader :name
  alias inspect :name
  def letter; name.first; end
  alias path :letter

  def index; NAMES.index @name; end
  def <=>(other); index <=> other.index; end


  ALL = NAMES.collect {|name| self.new name}
  def self.all; ALL[0,4]; end
  def self.with_generic; ALL; end
  def self.each(&block);ALL[0,4].each(&block); end
  def self.generic; ALL.last; end
  def generic?; self.class.generic == self; end
  def display; generic? ? '' : letter; end

  def symbolic_name; generic? ? name : [letter.colon, name].to_phrase; end
  def adjective; %w{physical material social mental \ }[index]; end
  def adverb; adjective.ly; end

  ALL.each_with_index do |instance, index|
    %w{ name letter}.each do |thing|
      define_singleton_method(instance.send(thing)) {ALL[index]}
      define_singleton_method(instance.send(thing).downcase) {ALL[index]}
    end
  end

  # no-ops to allow easy mapping
  def flip; self; end
  alias flop :flip
  alias opposite :flip

  def +(behavior); Triplet.find([behavior, self]); end

  def mbti; %w{S T F N X}[index]; end
  def verb_phrase; %w{Take Buy Say Make Do}[index] + ' the best ' + %w{actions things things choices \ }[index] + ' you can, given the '; end

  # method name must match Behavior send_name or send_action
  def flee; %w{Walk Pay\ cash Emote Decide Flee}[index]; end
  def burn_energy
    [flee.period,
     verb_phrase + %w{energy currency feelings information energy}[index] + ' you have.',
     %w{Burn\ calories Spend\ money Express\ emotions Synthesize\ facts  Burn\ energy}[index] + ' for fun, because you feel ' + adverb + ' restless, or to improve your ' + %w{body finances mood mind self}[index]
    ].to_phrase.cleaned.period
  end

  def strength_examples;
    ['Farm, hunt, garden, build bridges, or dig ditches.',
    'Buy cars, houses, investments, or other capital goods.',
    'Write lyrics, poetry, stories, or make speeches.',
    'Make plans, procedures, rules, predictions, or extrapolations.',
    ][index]
  end

  def fight; %w{Do\ housework Use\ credit Verbalize Theorize Fight}[index]; end
  def use_strength
    [fight.period,
     verb_phrase + %w{muscles loans vocabulary analogies strengths}[index] + ' you have.',
     strength_examples,
     'Use your ' + %w{body reputation voice mind power}[index] + ' to achieve a goal, because you feel driven, or to do ' + adjective + ' work'
    ].to_phrase.cleaned.period
  end

  def get_energy
    case mbti
    when 'S'
      'Eat carbs. Eat candy or dessert. Load up on potatoes, bread, pasta and rice. Digest simple carbs.'
    when 'T'
      'Collect wages. Collect tips, bonuses, commissions, and profits. Compete for rewards. Earn cash prizes.'
    when 'F'
      'Listen to music. Turn on the radio. Listen to instruments or nature sounds. Understand emotional intonation.'
    when 'N'
      'Look at details. Watch current events. Research. Learn causes and specifics and detailed facts.'
    else
      'Feed. Take and process energy sources.'
    end
  end

  def recover_strength
    case mbti
    when 'S'
      'Eat protein. Digest amino acids. And then rest your body to give your muscles time to recover.'
    when 'T'
      'Collect stipends. Collect a salary, allowance, social security, dividends, interest, rental income or other regular income. And then rest your wallet to give your credit time to recover.'
    when 'F'
      'Listen to words. Hear speaches or stories or lyrics. Read poetry. Understand lexical meaning. And then rest your voice to give your vocabulary time to recover.'
    when 'N'
      'Look at results. Learn rules and generalizations and patterns and effects. And then rest your mind to give your analogies time to recover.'
    else
      'Rest. Go after, take or accept, and process resources that can repair, rebuild, and develop your strengths. And then give them time to recover before using them again.'
    end
  end

  def stop
    case mbti
    when 'S'
      'brush your teeth'
    when 'N'
      'close your eyes'
    when 'T'
      'put down the tools'
    when 'F'
      'turn off the sound'
    else
      'stop pursuing strengtheners'
    end
  end

  def organ; %w{body wallet voice mind strengths}[index]; end
end
