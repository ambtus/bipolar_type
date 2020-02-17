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

  def adjective; %w{physical mental spiritual material}[index]; end
  def adverb; adjective + "ly"; end

  def energy; %w{calories facts emotions money}[index]; end
  def less; %w{fewer fewer less less}[index]; end

  def evaluate; %w{smell see hear touch}[index]; end
  def source; %w{food result voice tool}[index]; end
  def sources; source.pluralize; end
  def evaluate_sources; [evaluate, sources].to_phrase; end
  def appear; %w{taste look sound feel}[index]; end
  def unhealthy; %w{disgusting frightening hateful frustrating}[index]; end
  def sick; %w{disgusted afraid ashamed angry}[index]; end

  def achieve; %w{cultivate imagine influence build}[index]; end
  def goal; %w{place possibility person thing}[index]; end
  def goals; goal.pluralize; end
  def achieve_goals; [achieve, goals].to_phrase; end

  def get_energy; %w{eat analyze listen earn}[index]; end
  def use_energy; %w{move synthesize talk spend}[index]; end
end
