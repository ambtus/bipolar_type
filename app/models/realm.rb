class Realm < Concept

  ########
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  PATHS.each do |path|
    define_singleton_method(path) {ALL[PATHS.index(path)]}
  end
  %w{first second third fourth}.each_with_index do |ordinal, index|
    define_singleton_method(ordinal) {ALL[index]}
  end
  ########

  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  def +(attitude); subtypes.find{|s| s.attitude == attitude}; end

  def adjective; %w{physical mental spiritual material}[index]; end
  def name; adjective.titleize; end
  def energy; %w{calories facts opinions cash}[index]; end
  def energetic; %w{caloric factual social financial}[index]; end
  def reserves; %w{fat knowledge friends savings}[index]; end

  def sense; %w{smell/taste see hear touch}[index]; end
  def consume; %w{eat believe empathize\ with use}[index]; end
  def external; %w{food information perspectives tools}[index]; end
  def take; %w{eat learn listen\ to collect}[index]; end

  def produce; %w{do plan prioritize buy}[index]; end

  def empty; %w{hungry curious lonely needy}[index]; end
  def give; %w{cook show talk pay}[index]; end
  def more; %w{sweeter brighter louder easier}[index]; end
  def least; %w{faintest smallest quietest least}[index]; end
  def stimuli; %w{smells sights voices rewards}[index]; end
  def taker; %w{eater student listener worker}[index]; end
  def giver; %w{cook teacher speaker employer}[index]; end
  def provide; %w{feed show tell pay}[index]; end
  def provided; %w{fed shown told paid}[index]; end
end
