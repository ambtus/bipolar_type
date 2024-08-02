class Realm

  def initialize(mbti); @mbti = mbti; end
  attr_reader :mbti
  alias path :mbti
  alias inspect :mbti

  MBTIS = %w{S T F N X}
  def index; MBTIS.index @mbti; end


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
       'Physical exercises or games. Burning calories for fun, to make yourself happy, or to improve your body.'
    when 'N'
       'Mental exercises or games. Solving problems for fun, to make yourself happy, or to improve your mind.'
    when 'T'
       'Paying upfront or paying off debts. Spending cash for fun, to make yourself happy, or to improve your finances.'
    when 'F'
       'Singing or talking. Expressing emotions for fun, to make yourself happy, or to improve your mood.'
    else
       'Playing or exercising. Burning energy for pleasure or because it is healthy.'
    end
  end

  def use_strength
    case mbti
    when 'S'
       'Physical work or labor. Using your body to achieve a goal.'
    when 'N'
       'Mental work or labor. Using logic or analogies to solve a problem.'
    when 'T'
       'Taking out loans or mortgages. Paying with credit to buy a thing.'
    when 'F'
       'Writing or making speaches. Using language to express an idea.'
    else
       'Work or Labor. Using strength in goal-directed activities.'
    end
  end

  def get_energy
    case mbti
    when 'S'
      'Eating candy or dessert. Loading up on potatoes, bread, pasta and rice. Digesting simple carbs.'
    when 'N'
      'Researching. Watching current events. Learning specific facts.'
    when 'T'
      'Earning wages. Competing for rewards. Collecting cash prizes.'
    when 'F'
      'Listening to instrumental music. Turning on the radio. Understanding emotional intonation.'
    else
      'Going after, taking or accepting, and processing energy sources.'
    end
  end

  def recover_strength
    case mbti
    when 'S'
      'Eating protein. And then resting your body to give your muscles time to recover.'
    when 'N'
      'Watching results. And then resting your mind to give your mental models time to recover.'
    when 'T'
      'Earning a salary or other regular income. And then resting your wallet to give your credit time to recover.'
    when 'F'
      'Listening to speaches or audiobooks. And then resting your voice to give your language skills time to recover.'
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
      'go home'
    when 'F'
      'turn off the sound'
    else
      'stop pursuing strengtheners'
    end
  end
end
