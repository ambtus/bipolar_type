class Behavior

  def initialize(symbol); @symbol = symbol; end
  attr_reader :symbol
  alias path :symbol

  NAMES = %w{BurnEnergy UseStrength GetEnergy RecoverStrength} # tl,tr,bl,br. not cycle order
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


  def subtypes; Subtype.all.select{|s| s.behavior == self}; end
  def +(realm); subtypes.find{|s| s.realm == realm}; end

  def realm; Realm.generic; end
  def method_missing(meth, *arguments, &block)
    if realm.respond_to?(meth)
      realm.send(meth, *arguments, &block)
    else
      super
    end
  end

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

  def compulsive_names; [(unhappy? ? 'Unhappy' : 'Unhealthy'), first_name] ; end
  def compulsive_name; [compulsive_names.map(&:first).join.colon, compulsive_names.wbr].to_safe_phrase; end
  def responsible_names; ['More', first_name] ; end
  def responsible_name; [responsible_names.map(&:first).join.colon, responsible_names.wbr].to_safe_phrase; end
  def conscious_names;[(unhappy? ? 'Healthy' : 'Happy'), first_name] ; end
  def conscious_name; [conscious_names.map(&:first).join.colon, conscious_names.wbr].to_safe_phrase; end
  def limited_names; ['Less', first_name] ; end
  def limited_name; [limited_names.map(&:first).join.colon, limited_names.wbr].to_safe_phrase; end

  def good_adverb; unhappy? ? 'healthy' : 'happy'; end

end
