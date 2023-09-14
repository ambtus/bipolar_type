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

  def center; %w{calories information affect posessions}[index]; end
  def adjective; %w{physical mental affective financial}[index]; end

end
