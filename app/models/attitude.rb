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

  def problem; %w{ binge depression mania splurge}[index]; end
  def name; problem.capitalize; end

  def first; symbol.chars.first; end
  def second; symbol.chars.second; end

  def balanced?; [1,2].include?(index); end
  def e?; first == "E"; end
  def p?; second == "P"; end

end
