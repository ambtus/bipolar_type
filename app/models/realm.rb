class Realm

  NAMES = %w{Physical Financial Affective Mental Generic}

  def initialize(name); @name = name; end
  attr_reader :name
  alias inspect :name
  def letter; name.first; end
  alias path :letter

  def index; NAMES.index @name; end
  def <=>(other); index <=> other.index; end
  def mbti; %w{S T F N X}[index]; end


  ALL = NAMES.collect {|name| self.new name}
  def self.all; ALL[0,4]; end
  def self.with_generic; ALL.values_at(4,3,2,0,1); end
  def self.each(&block);ALL[0,4].each(&block); end
  def self.generic; ALL.last; end
  def generic?; self.class.generic == self; end
  def display; generic? ? '' : letter; end

  def symbolic_name; generic? ? name : [letter.colon, name].to_phrase; end
  def adjective; generic? ? '' : name.downcase; end
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
  def triplets; Triplet.all.select{|t| t.realm == self}; end
  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  def cycles; Cycle.all.select{|c| c.triplet.realm == self}; end

  def internalize; %w{eat earn listen\ to look\ at internalize}[index]; end
  def externalize; %w{do buy express think externalize}[index]; end

  # method names must match Behavior send_action send_name send_examples

  def feed; %w{Sweets Wages Music Pictures Feed}[index]; end
  def flee; %w{Pace Pay\ Cash Cry Guess Flee}[index]; end
  def fight; %w{Clean Borrow Complain Theorize Fight}[index]; end
  def rest; %w{Protein Income Words Results Rest}[index]; end

  def energies; %w{calories cash emotions information energy}[index]; end
  def burn; %w{burn spend express synthesize expend}[index]; end
  def organ; %w{body wallet mood mind self}[index]; end
  def burn_energy; "#{burn} #{energies} to protect or exercise your #{organ}".clean; end
  def perceive; %w{eat earn listen\ to look\ at perceive}[index]; end
  def process; %w{digest collect prioritize analyze process}[index]; end
  def get_energy; "#{perceive}, #{process}, and store #{energies}"; end


  def strengths; %w{muscles loans vocabulary logic strengths}[index]; end
  def goals; %w{environment possessions story procedures situation}[index]; end
  def use_strength; "use #{strengths} to improve your #{goals}".clean; end
  def recover; %w{rebuild make\ payments\ on restore repair recover}[index]; end
  def recover_strength; "#{recover} your #{strengths}".clean.gsub('yourself', ''); end

  def flee_examples; end
  def feed_examples
    case mbti
    when "S"
      "#{internalize.capitalize} snacks and desserts. Carb-load and store excess as fat."
    when "T"
      "#{internalize.capitalize} tips, bonuses, and profits. Compete for cash prizes."
    when "F"
      "#{internalize.capitalize} pitch and inflection. Hear and understand intonation."
    when "N"
      "#{internalize.capitalize} color and movement. Watch and learn specific details."
    else
      ''
    end
  end

  def rest_examples
    return '' if generic?
      "#{internalize.capitalize} #{rest.downcase}. And then stop #{fight.downcase.ing} and give your #{organ} time to recover."
  end

  def fight_examples;
    ['Produce food — farm, hunt, garden — or other physical labor.',
    'Build shelters — Buy cars, houses, investments, or other capital goods.',
    'Explain why — Write lyrics, poetry, stories, or make speeches.',
    'Decide how — Make plans, procedures, rules, predictions, or extrapolations.',
    ][index]
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

end
