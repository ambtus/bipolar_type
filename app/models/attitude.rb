class Attitude < Concept

  SYMBOLS = %w{LL UL UR LR}

  ########
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  PATHS = SYMBOLS.map(&:downcase)
  PATHS.each do |path|
    define_singleton_method(path) {ALL[PATHS.index(path)]}
  end
  ########

  SYMBOLS.each do |symbol|
    define_singleton_method(symbol.downcase) {ALL[SYMBOLS.index(symbol)]}
  end

  def path; symbol.downcase; end

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end
  def +(realm); subtypes.find{|s| s.realm == realm}; end

  def upper?; symbol.first == "U"; end
  def left?; symbol.last == "L"; end
  def diagonal?; symbol == "UL" || symbol == "LR"; end

  def adjective; %w{depressed energetic relaxed  manic}[index]; end
  def name; adjective.capitalize; end

end
