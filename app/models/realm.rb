class Realm

  def initialize(mbti); @mbti = mbti; end
  attr_reader :mbti
  alias path :mbti
  alias inspect :mbti

  MBTIS = %w{S T F N X}
  def index; MBTIS.index @mbti; end
  def <=>(other); index <=> other.index; end


  ALL = MBTIS.collect {|mbti| self.new mbti}
  def self.all; ALL[0,4]; end
  def self.with_generic; ALL; end
  def self.each(&block);ALL[0,4].each(&block); end
  def self.generic; ALL.last; end
  def generic?; self.class.generic == self; end
  def display; generic? ? '' : @mbti; end

  NAMES = %w{Physical Financial Affective Mental Generic}
  def name; NAMES[index]; end
  def symbolic_name; [@mbti.colon, name].to_phrase; end
  def adjective; generic? ? '' : name.downcase; end
  def adverb; adjective.ly; end

  ALL.each_with_index do |instance, index|
    %w{mbti name}.each do |thing|
      define_singleton_method(instance.send(thing)) {ALL[index]}
      define_singleton_method(instance.send(thing).downcase) {ALL[index]}
    end
  end


  # method name must match Behavior send_name
  def burn_energy
    case mbti
    when 'S'
       'Play physical games. Do physical exercises. Burning calories for fun, to make yourself happy, or to improve your body.'
    when 'N'
       'Play mental games. Do mental exercises. Solving problems for fun, to make yourself happy, or to improve your mind.'
    when 'T'
       'Pay cash. Pay upfront or pay off debts. Spending cash for fun, to make yourself happy, or to improve your finances.'
    when 'F'
       'Sing. Talk to a friend or therapist. Expressing emotions for fun, to make yourself happy, or to improve your mood.'
    else
       'Play or exercise. Burning energy for pleasure or because it is healthy.'
    end
  end

  def use_strength
    case mbti
    when 'S'
       'Do physical labor. Build houses. Farm. Hunt or garden. Use your body to achieve a goal.'
    when 'N'
       'Do mental labor. Theorize. Make plans, develop procedures. Work with your mind. Use logic or analogies to solve a problem.'
    when 'T'
       'Use credit. Take out loans or mortgages. Buy something and then pay for it later.'
    when 'F'
       'Write. Make speaches. Write lyrics or poetry. Using language to express an idea.'
    else
       'Work or Labor. Using strength in goal-directed activities.'
    end
  end

  def get_energy
    case mbti
    when 'S'
      'Eat carbs. Eat candy or dessert. Loading up on potatoes, bread, pasta and rice. Digesting simple carbs.'
    when 'N'
      'Watch current events. Research. Learning causes and specific and detailed facts.'
    when 'T'
      'Earn wages. Competing for rewards. Collecting cash prizes.'
    when 'F'
      'Listen to music. Turn on the radio. Listen to instruments or nature sounds. Understanding emotional intonation.'
    else
      'Going after, taking or accepting, and processing energy sources.'
    end
  end

  def recover_strength
    case mbti
    when 'S'
      'Eat protein. Digesting amino acids. And then resting your body to give your muscles time to recover.'
    when 'N'
      'Watch results. Learning rules and gerealizations and patterns and  effects. And then resting your mind to give your theories time to recover.'
    when 'T'
      'Earn a salary. Collect a stipend or other regular income. And then rest your wallet to give your credit time to recover.'
    when 'F'
      'Listen to stories. Hear speaches or audiobooks or lyrics. Read poetry. Understand lexical meaning. And then rest your voice to give your morals time to recover.'
    else
      'Going after, taking or accepting, and processing resources that can repair, rebuild, and develop your strengths. And then rest to give them time to recover before using them again.'
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
