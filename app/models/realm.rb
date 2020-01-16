class Realm < Concept

  SYMBOLS = %w{S N F T}

  ########
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  PATHS.each do |path|
    define_singleton_method(path) {ALL[PATHS.index(path)]}
  end
  ########

  SYMBOLS.each do |symbol|
    define_singleton_method(symbol.downcase) {ALL[SYMBOLS.index(symbol)]}
  end

  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  def +(attitude); subtypes.find{|s| s.attitude == attitude}; end

  def rights; ALL.select{|x| x.index > self.index}; end

  def adjective; %w{physical mental affective financial}[index]; end
  def adverb; adjective + "ly"; end

  def energy; %w{calories facts love money}[index]; end

  def perceive; %w{taste see hear handle}[index]; end
  def source; %w{food result voice tool}[index]; end
  def perceive_sources; [perceive, source.pluralize].to_phrase; end

  def achieve; %w{go visualize tell buy}[index]; end
  def goal; %w{place possibility person thing}[index]; end
  def achieve_goals; [achieve, goal.pluralize].to_phrase; end

  def get_energy; %w{eat analyze listen earn}[index]; end
  def use_energy; %w{walk synthesize talk spend}[index]; end
end
