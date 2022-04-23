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

  def length; upper? ? "chronic" : "acute"; end
  def noun; left? ? "depression" : "mania"; end
  def adjective; [length, noun].to_phrase; end
  def name; adjective.titleize; end

  def mbti_first; upper? ? "E" : "I"; end
  def mbti_second; left? ? "P" : "J"; end
end
