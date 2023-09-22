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

  def use; %w{move think talk pay}[index]; end
  def get; %w{eat look listen invest}[index]; end
  def energy; %w{carbs colors tones time}[index]; end
  def strength; %w{protein outlines words money}[index]; end

  def get_strength; %w{meat rules stories dividends}[index]; end
  def get_energy; %w{potatoes facts songs wages}[index]; end
  def use_energy; %w{gather specify sing cash}[index]; end
  def use_strength; %w{hunt generalize write interest}[index]; end
end
