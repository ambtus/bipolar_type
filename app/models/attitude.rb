class Attitude < Concept

  SYMBOLS = %w{S N F T}

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

  def adjective; %w{fat sore sick thin}[index]; end

  def happy?; st?; end
  def balanced?; nf?; end
  def pain; sn? ? "output" : "intake"; end

end
