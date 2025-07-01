class Realm < Concept
  SYMBOLS = %i{F S N T}
  ALL = SYMBOLS.collect { |symbol| self.new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def subtypes; Subtype.all.select { |x| x.realm == self }; end
  def +(attitude); subtypes.find { |x| x.attitude == attitude }; end

  def focus; %w{person place idea thing}[index]; end
  def foci; focus.pluralize; end
  def name; foci.capitalize; end

  def empty; %w{lonely hungry curious envious}[index]; end
  def organ; %w{soul body mind wallet}[index]; end

  def adjective; %w{social physical mental financial}[index]; end
  def adverb; adjective.ly; end
  def letter; adjective.first.capitalize; end

  def get; %w{listen\ to eat watch collect}[index]; end
  def energy; %w{music carbs the\ sunrise wages}[index]; end
  def strength; %w{stories protein the\ results dividends}[index]; end
  def get_energy; [get, energy].to_phrase; end
  def recover_strength; [get, strength].to_phrase; end
  def burn_energy; %w{talk walk use\ intuition pay\ cash}[index]; end
  def use_strength; %w{write do\ housework use\ logic use\ credit}[index]; end
end
