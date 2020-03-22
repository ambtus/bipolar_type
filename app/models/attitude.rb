class Attitude < Concept

  SYMBOLS = %w{P E I J}

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

  def adjective; %w{strong both neither energetic}[index]; end

  def realm_first?; [0,3].include?(index); end

  def sensitive?; index > 1; end
  def restless?; index.even?; end

end
