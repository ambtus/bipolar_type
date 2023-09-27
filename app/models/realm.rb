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
  def problems; Problem.all.select{|s| s.realm == self}; end
  def +(thing)
     behaviors.find{|b| b.generic_behavior == thing} ||
     problems.find{|p| p.generic_problem == thing}
  end

  def word; %w{physical mental affective financial}[index]; end

  def mbti; %w{S N F T}[index]; end

  # The following are examples, not definitions, behavior.eg, not behavior.ie
  def use_energy; %w{walk imagine talk buy}[index]; end
  def get_energy; %w{binge inspect listen work}[index]; end
  def use_strength; %w{toil theorize write borrow}[index]; end
  def get_strength; %w{gorge watch read invest}[index]; end

end
