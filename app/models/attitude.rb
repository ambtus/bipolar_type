class Attitude < Concept

  SYMBOLS = %w{F N T S}

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

  def sf?; %w{S F}.include?(symbol); end
  def nf?; %w{N F}.include?(symbol); end
  def ft?; %w{F T}.include?(symbol); end

end
