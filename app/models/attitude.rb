class Attitude < Concept

  SYMBOLS = %w{UL UR LL LR}

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


  def upper?; symbol.first == "U"; end
  def left?; symbol.last == "L"; end
  def diagonal?; symbol == "UL" || symbol == "LR"; end



  def causality; upper? ? "effect" : "cause"; end
  def episode; left? ? "depression" : "mania"; end
  def description; [episode, causality].to_phrase; end
  def name; description.titleize; end

end
