class Realm < Concept

  SYMBOLS = %i{F S N T}

  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each do |sym|
    define_singleton_method(sym) {ALL.find{|s| s.symbol == sym}}
  end

  def subtypes; Subtype.all.select{|x| x.realm == self}; end
  def +(attitude); subtypes.find{|x| x.attitude == attitude}; end

  def focus; %w{person place idea thing}[index]; end
  def foci; focus.pluralize; end
  def name; foci.capitalize; end

  def adjective; %w{social physical mental financial}[index]; end
  def letter; adjective.first.capitalize; end

  def get; %w{listen\ to eat learn earn}[index]; end
  def energy; %w{music carbs facts wages}[index]; end
  def strength; %w{sermons protein rules a\ salary}[index]; end
  def get_energy; [get, energy].to_phrase; end
  def get_strength; [get, strength].to_phrase; end

  def use; %w{communicate move think buy}[index]; end
  def use_energy; %w{sing travel choose pay\ cash}[index]; end
  def use_strength; %w{preach labor decide use\ credit}[index]; end

end
