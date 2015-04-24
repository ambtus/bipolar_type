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

  def self.rules; Realm.all.third; end
  def self.stories; Realm.all.fourth; end

  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  def others; Realm.all - [self]; end
  def opposite; Realm.all[(@index + 2).modulo(4)]; end
  def wings; others - [opposite]; end

  def neuro; %w{serotonin dopamine GABA oxytocin}[@index]; end
  def neuro_up; neuro.slice(0).upcase + neuro.slice(1..-1); end

  def mbti; %w{T S N F}[@index]; end
  def adjective; %w{financial physical cognitive interpersonal}[@index]; end
  def description; adjective.capitalize; end
  def description_with_mbti; "#{description} (#{mbti})"; end

  def full; %w{rich fat factual liberal}[@index]; end
  def empty; %w{poor thin theoretical conservative}[@index]; end
  def balanced; [full, empty].join(" or "); end


  def consume; %w{work eat start hear}[@index]; end
  def unit; %w{hour meal puzzle story}[@index]; end
  def produce_we; %w{spend burn put\ together understand}[@index]; end
  def energy; %w{dollar kcal piece viewpoint}[@index]; end
  def produce; %w{buy do synthesize influence}[@index]; end
  def things; %w{things things things people}[@index]; end
  def unproduced; "un" + produce.ed; end

  # make the numbers look reasonable and equivalent
  # when multiplied by the attitude.send(realm)
  def bursty; [80, 1800, 2000, 8][@index]; end
  def over; [20, 900, 1000, 4][@index]; end
  def average; [10, 600, 500, 3][@index]; end
  def under; [8, 450, 300, 2][@index]; end
  def steady; [7, 300, 100, 1][@index]; end

  def energy_unit; [energy, unit].join("-"); end

  def median; [8, 3, 4, 3][@index]; end

  def average_unit; [average, energy_unit.pluralize].join("-"); end
  def short; "#{consume} #{median.word} #{average_unit}"; end

  def shorter; "#{consume} #{unit.pluralize}"; end
end
