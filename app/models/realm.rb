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
  def description; adjective.capitalize; end
  def description_with_mbti; "#{description} (#{mbti})"; end

  def full; %w{rich fat factual talkative}[@index]; end
  def empty; %w{austere thin theoretical quiet}[@index]; end

  # size of chunks
  # make the numbers look reasonable and equivalent
  # when multiplied by the attitude.send(realm)
  def bursty; [80, 1800, 2000, 8][@index]; end
  def over; [20, 900, 1000, 4][@index]; end
  def median_size; [10, 600, 500, 3][@index]; end
  def under; [8, 450, 300, 2][@index]; end
  def steady; [7, 300, 100, 1][@index]; end

  def energy; %w{dollar kcal piece viewpoint}[@index]; end
  def chunk; %w{hour meal puzzle story}[@index]; end
  def energy_chunk; [energy, chunk].join("-"); end

  # get energy
  def get; %w{work eat start hear}[@index]; end
  # use energy
  def use; %w{spend burn put\ together express}[@index]; end

  # act => get energy
  def a; chunk == "hour" ? "an" : "a"; end
  def act(modifier=""); "#{get} #{modifier} #{chunk.pluralize}".squish; end

  # act normally
  def median_chunks; [8, 3, 4, 3][@index]; end
  def normal_chunks; "#{median_chunks.word} #{chunk.pluralize}"; end
  def median_energy_chunks; [median_size, energy_chunk.pluralize].join("-"); end
  def act_normally; "#{get} #{median_chunks.word} #{median_energy_chunks}"; end

  # react normally
  def react_normally(modifier=bursty.word); "#{use} #{modifier} #{energy.pluralize}".squish; end

  # an alternative description of reacting => use energy to "produce things"
  def produce; %w{buy do synthesize say}[@index]; end
  def react(how_many=""); "#{produce} #{how_many} things".squish; end

end
