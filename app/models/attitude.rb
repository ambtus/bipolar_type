class Attitude < Concept

  SYMBOLS = %w{N F S T }

  ########
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  PATHS.each do |path|
    define_singleton_method(path) {ALL[PATHS.index(path)]}
  end
  ########

  def self.answer_order; ALL.values_at(0,2,1,3); end

  SYMBOLS.each do |symbol|
    define_singleton_method(symbol.downcase) {ALL[SYMBOLS.index(symbol)]}
  end

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end
  def +(realm); subtypes.find{|s| s.realm == realm}; end

  def ft?; %w{F T}.include?(symbol); end
  def sf?; %w{S F}.include?(symbol); end
  def nf?; %w{N F}.include?(symbol); end

end
