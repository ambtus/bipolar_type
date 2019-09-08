class Attitude < Concept

  SYMBOLS = %w{EP EJ IP IJ}

  ########
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  PATHS.each do |path|
    define_singleton_method(path) {ALL[PATHS.index(path)]}
  end
  ########

  def self.answer_order; ALL; end

  SYMBOLS.each do |symbol|
    define_singleton_method(symbol.downcase) {ALL[SYMBOLS.index(symbol)]}
  end

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end
  def +(realm); subtypes.find{|s| s.realm == realm}; end

  SYMBOLS.permutation(2).each do |ary|
    pair = ary.join.downcase
    define_method(pair + "?") {ary.include?(@symbol)}
  end

  def dominant; %w{get_energy get_strength use_energy use_strength}[index]; end
  def divert; %w{ get_strength get_energy  use_strength use_energy}[index]; end
  def balance; %w{use_energy use_strength get_energy get_strength}[index]; end
  def opposite; %w{use_strength use_energy get_strength  get_energy}[index]; end
end
