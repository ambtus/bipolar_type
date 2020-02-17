class Attitude < Concept

  SYMBOLS = %w{EP EJ IP IJ}

  ########
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  PATHS.each do |path|
    define_singleton_method(path) {ALL[PATHS.index(path)]}
  end
  ########

  SYMBOLS.each do |symbol|
    define_singleton_method(symbol.downcase) {ALL[SYMBOLS.index(symbol)]}
  end

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end
  def +(realm); subtypes.find{|s| s.realm == realm}; end

  def adjective; %w{depressed productive discriminating manic}[index]; end

  def first; symbol.chars.first; end
  def second; symbol.chars.second; end

  def get?; index.even?; end
  def get_or_use; get? ? "get" : "use"; end

  def less?; [0,3].include?(index); end
  def less_or_more; less? ? "less" : "more"; end

  def solution; [get_or_use, less_or_more, "energy"].to_phrase; end


  def focus; get? ? "resources" : "goals"; end

  def fat?; index < 2; end
  def imbalance; fat? ? "surplus" : "deficit"; end
  def episode; fat? ? "depression" : "mania"; end

end
