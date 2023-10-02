class Realm < Concept
  # Jungian Function

  SYMBOLS = %w{P M A F}

  def initialize(string); @symbol = string; end


  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  def self.all; self::ALL; end
  def self.each(&block);self::ALL.each(&block); end
  SYMBOLS.each{|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  def inspect; @symbol; end
  def index; self.class::SYMBOLS.index @symbol; end

  def behaviors; Behavior.all.select{|s| s.realm == self}; end
  def +(thing); behaviors.find{|b| b.phase == thing}; end

  def word; %w{physical mental affective financial}[index]; end

  def mbti; %w{S N F T}[index]; end

  # The following are examples, not definitions, behavior.eg, not behavior.ie
  def use_energy; %w{walk know sing spend\ cash}[index]; end
  def get_energy; %w{eat\ carbs look\ at\ facts listen\ to\ music earn\ cash}[index]; end
  def use_strength; %w{lift\ weights theorize write\ words borrow}[index]; end
  def get_strength; %w{eat\ protein watch\ results read\ words invest}[index]; end

  def reserves; %w{fat\ cells ?? mood ??}[index]; end
  def powers; %w{muscles mental\ models vocabulary credit\ limit}[index]; end

end
