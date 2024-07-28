class Problem

  def initialize(symbol); @symbol = symbol; end
  attr_reader :symbol
  alias path :symbol

  NAMES = %w{BurnEnergy UseStrength GetEnergy RecoverStrength} # tltrblbr, not cycle order
  SYMBOLS = NAMES.map(&:first)

  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  def self.all; ALL; end
  def self.each(&block);self.all.each(&block); end
  def index; SYMBOLS.index @symbol; end
  def mbti; %w{EP EJ IP IJ}[index]; end
  ALL.each_with_index do |instance, index|
    %w{symbol mbti}.each do |thing|
      define_singleton_method(instance.send(thing)) {ALL[index]}
      define_singleton_method(instance.send(thing).downcase) {ALL[index]}
    end
  end
  %w{first second third fourth}.each do |ordinal|
    define_singleton_method(ordinal) {ALL.send(ordinal)}
  end

  def name; NAMES[index]; end
  alias inspect :name
  def first_name; name.to_words.first; end
  def symbolic_name; [symbol.colon, first_name].to_safe_phrase; end


  def subtypes; Subtype.all.select{|s| s.problem == self}; end
  def +(realm); subtypes.find{|s| s.realm == realm}; end

  def realm; Realm.generic; end

  def internal?; index > 1 ; end
  def energy?; index.even?; end
  def behavior; name.underscore; end

  CYCLE = ALL.values_at(2,0,1,3,2,0,1)
  def self.by_cycle; CYCLE[0,4]; end
  def cycle_index; CYCLE.index self; end
  def unhappy?; cycle_index.odd?; end
  def next; CYCLE[cycle_index+1]; end
  def opposite; CYCLE[cycle_index+2]; end
  def previous; CYCLE[cycle_index+3]; end

  def problem_names; [(unhappy? ? 'Unhappy' : 'Unhealthy'), first_name] ; end
  def problem_name; [symbol.colon, problem_names.wbr].to_safe_phrase; end

  def good_adverb; unhappy? ? 'healthy' : 'happy'; end

end
