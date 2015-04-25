class Realm
  LETTERS = %w{a b c d}

  def initialize(string)
    @index = LETTERS.index(string)
    raise "#{string} isn't a Realm" unless @index
    @letter = string
  end
  attr_reader :letter

  REALMS = LETTERS.collect{|choice| Realm.new(choice)}
  def self.all; REALMS; end
  def self.find(letter); REALMS[LETTERS.index(letter)]; end

  def subtypes; Subtype.all.select{|s| s.realm == self}; end

  def neuro; %w{serotonin dopamine GABA oxytocin}[@index]; end
  def neuro_up; neuro.slice(0).upcase + neuro.slice(1..-1); end

  def mbti; %w{T S N F}[@index]; end
  def adjective; %w{financial physical cognitive interpersonal}[@index]; end
  def sick; %w{poor hungry unsure suicidal}[@index]; end
  def death; %w{poverty starvation stupidity suicide}[@index]; end
  def description; adjective.capitalize; end
  def description_with_mbti; "#{description} (#{mbti})"; end

  def full; %w{rich fat factual submissive}[@index]; end
  def empty; %w{indebted thin hypothetical dominant}[@index]; end

  # size of chunks
  # make the numbers look reasonable and equivalent
  # when multiplied by the attitude.send(realm)
  def bursty; [80, 1800, 1000, 9][@index]; end
  def over; [40, 900, 500, 5][@index]; end
  def median_size; [26, 600, 400, 3][@index]; end
  def under; [20, 450, 300, 2][@index]; end
  def steady; [13, 300, 100, 1][@index]; end

  def hypomanic; over * 3; end
  def manic; bursty * 3; end

  def energy; %w{dollar kcal piece viewpoint}[@index]; end
  def energies; energy.pluralize; end
  def chunk; %w{paid-hour meal puzzle story}[@index]; end
  def chunks; chunk.pluralize; end
  def energy_chunk; [energy, chunk].join(" "); end
  def energy_chunks; energy_chunk.pluralize; end

  # get energy
  def get; %w{work eat analyze listen\ to}[@index]; end
  # use energy
  def use; %w{spend burn fit\ together express}[@index]; end

  # act => get energy
  def act(modifier=""); "#{get} #{modifier} #{chunks}".squish; end

  # react => use energy to "produce things"
  def produce; %w{buy do decide say}[@index]; end
  def react(modifier=""); "#{produce} #{modifier} things".squish; end

  # act normally
  def median_size_energy_chunks; [median_size, energy_chunks].join("-"); end
  def act_normally(modifier=""); "#{get} #{modifier} three #{median_size_energy_chunks} a day".squish; end

  # react normally
  def react_normally(modifier=""); "#{use} #{modifier} #{bursty.word} #{energies} a day".squish; end


end
