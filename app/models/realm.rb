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

  def adjective; %w{physical mental emotional financial}[index]; end
  def adverb; adjective + "ly"; end

  def energy; %w{calories information emotions money}[index]; end

  def target; %w{place idea person thing}[index]; end
  def targets; target.pluralize; end
  def hit; %w{go consider tell buy}[index]; end

  def intake; %w{eat look\ at listen\ to collect}[index]; end
  def strengtheners; %w{protein results sermons earnings}[index]; end
  def energizers; %w{carbs art music profits}[index]; end
  def bad; %w{sick afraid ashamed angry}[index]; end

end
