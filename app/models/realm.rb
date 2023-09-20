class Realm < Concept

  SYMBOLS = %w{P M A F}

  def initialize(string); @symbol = string; end


  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  def self.all; self::ALL; end
  def self.each(&block);self::ALL.each(&block); end
  SYMBOLS.each{|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  def inspect; @symbol; end
  def index; self.class::SYMBOLS.index @symbol; end

  def behaviors; Behavior.all.select{|s| s.realm == self}; end
  def solutions; Solution.all.select{|s| s.realm == self}; end
  def +(thing)
     behaviors.find{|b| b.generic_behavior == thing} ||
     solutions.find{|s| s.generic_solution == thing}
  end

  def word; %w{physical mental affective financial}[index]; end
  def mbti; %w{S N F T}[index]; end

  def get; %w{eat look\ at listen\ to earn}[index]; end
  def process; %w{digest learn understand collect}[index]; end

  def external_strength; %w{protein patterns words allowances}[index]; end
  def get_strength; "#{get} #{external_strength}"; end
  def process_strength; "#{process} #{external_strength}"; end

  def external_strength_examples
    case external_strength
    when "protein"
      %w{fish meat eggs}
    when "patterns"
      %w{generalities outlines rules}
    when "words"
      %w{stories lyrics poems}
    when "allowances"
      %w{salaries interest dividends}
    end
  end

  def external_energy; %w{carbs details intonation rewards}[index]; end
  def get_energy; "#{get} #{external_energy}: #{external_energy_examples.or}"; end
  def process_energy; "#{process} #{external_energy}"; end

  def external_energy_examples
    case external_energy
    when "carbs"
      %w{sweets starches grains}
    when "details"
      %w{specifics colors exceptions}
    when "intonation"
      %w{music melodies harmony}
    when "rewards"
      %w{bonuses wages winnings}
    end
  end

  def get_more_energy; "#{get} more #{external_energy} (more #{external_energy_examples.or})"; end
  def get_less_energy; "#{get} #{external_energy.less} #{external_energy} (fewer #{external_energy_examples.or})"; end



  def use; %w{move choose communicate pay}[index]; end
  def achieve; %w{exercise plan communicate buy}[index]; end

  def with_energy; %w{slowly factually emotionally with\ cash}[index]; end
  def use_energy; "#{use} #{with_energy}"; end
  def achieve_energy; "#{achieve}: #{use_energy_examples.or}"; end

  def use_energy_examples
    case with_energy.last_word
    when "slowly"
      %w{walk jog swim}
    when "factually"
      %w{synthesize guess intuit make\ short-term\ plans}
    when "emotionally"
      %w{laugh cry scream shout}
    when "cash"
      %w{use\ debit write\ checks pay\ upfront}
    end
  end

  def with_strength; %w{quickly logically morally with\ credit}[index]; end
  def use_strength; "#{use} #{with_strength}: #{use_strength_examples.or}"; end
  def achieve_strength; "#{achieve}: #{use_strength_examples.or}"; end

  def use_strength_examples
    case with_strength.last_word
    when "quickly"
      %w{sprint lift\ weights box}
    when "logically"
      %w{analyze theorize program}
    when "morally"
      %w{write\ stories give\ sermons }
    when "credit"
      %w{use\ loans mortgage\ your\ home}
    end
  end

  def use_less_strength; "#{use} more #{with_energy} (more #{use_energy_examples.map(&:ing).or})"; end
  def use_more_strength; "#{use} more #{with_strength} (more #{use_strength_examples.map(&:ing).or})"; end

  def deficit; %w{anorexic amnesiac suicidal insolvent}[index]; end
  def surplus; %w{obese know-it-all homicidal miserly}[index]; end


end
