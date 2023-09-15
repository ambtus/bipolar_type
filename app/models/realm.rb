class Realm < Concept

  SYMBOLS = %w{P M A F}

  def initialize(string); @symbol = string; end


  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  def self.all; self::ALL; end
  def self.each(&block);self::ALL.each(&block); end
  SYMBOLS.each{|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  def inspect; @symbol; end
  def index; self.class::SYMBOLS.index @symbol; end

  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  def +(solution); subtypes.find{|s| s.solution == solution}; end

  def behaviors; Behavior.all.select{|s| s.realm == self}; end

  def adjective; %w{physical mental affective financial}[index]; end

  def name; adjective.capitalize; end

  def stored_energy; %w{fat knowledge self-esteem savings}[index]; end

  def surplus; %w{obese know-it-all homicidal cash-rich}[index]; end

  def deficit; %w{anorexic ignorant suicidal cash-starved}[index]; end

end
