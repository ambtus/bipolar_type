class Attitude < Concept

  SYMBOLS = %w{EP EJ IP IJ}

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

  def opposite; ALL[(index + 2).modulo(4)]; end
  def previous; ALL[(index + 3).modulo(4)]; end
  def subsequent; ALL[(index + 1).modulo(4)]; end


  def insensitive?; symbol.first == "E"; end
  def happy?; symbol.last == "P"; end
  def receptive?; symbol == "EP" || symbol == "IJ"; end

  def un; happy? ? "unbalanced" : "unhappy"; end
  def reason; happy? ? "unhappy" : "unbalanced"; end
  def bad; %w{full exhausted empty overwhelmed}[index]; end

  def phoria; happy? ? "euphoric" : "dysphoric"; end
  def state; insensitive? ? "depression" : "mania"; end
  def description; [phoria, state].to_phrase; end
  def name; description.titleize; end

  def imbalance; insensitive? ? "full" : "empty"; end
end
