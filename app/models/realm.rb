class Realm
  LETTERS = %w{e f g h}

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
  def others; Realm.all - [self]; end
  def opposite; Realm.all[(@index + 2).modulo(4)]; end
  def wings; others - [opposite]; end

  def mbti; %w{SF ST NT NF}[@index]; end
  def neuro; %w{serotonin dopamine GABA oxytocin}[@index]; end
  def neuro_up; neuro.slice(0).upcase + neuro.slice(1..-1); end

  def realm; %w{physical financial cognitive emotional}[@index]; end
  def description; realm.capitalize; end
  def empty; %w{hungry purse\ pinched unsure hopeless}[@index]; end
  def consume; %w{eat work learn listen\ to}[@index]; end
  def resources; %w{foods jobs rules stories}[@index]; end
  def organ; %w{stomach purse head heart}[@index]; end
  def full; %w{fat wealthy smart hopeful}[@index]; end
  def internal; %w{fat savings knowledge hope}[@index]; end
  def external; %w{larder workroom database library}[@index]; end
  def death; %w{starvation poverty stupidity suicide}[@index]; end
  def produce; %w{walk buy make\ decisions influence\ people}[@index]; end

  def spring(weak=false); "I am too #{full}"; end
  def summer(weak=false); "I am not overly #{full}"; end
  def autumn(weak=false); "I am not #{full} enough"; end
  def winter(weak=false); "I am barely #{full} enough"; end

end
