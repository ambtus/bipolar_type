class Realm < Concept

  SYMBOL = %i{F S T N }

  ALL = SYMBOL.collect {|symbol| self.new symbol}
  SYMBOL.each do |sym|
    define_singleton_method(sym) {ALL.find{|s| s.symbol == sym}}
  end

  def subtypes; Subtype.all.select{|x| x.realm == self}; end
  def +(attitude); subtypes.find{|x| x.attitude == attitude}; end

  def focus; %w{person place thing idea}[index]; end
  def foci; focus.pluralize; end
  def name; foci.capitalize; end

  def adjective; %w{social physical financial mental}[index]; end
  def adverb; adjective.ly; end

  def get; %w{listen\ to eat earn learn}[index]; end
  def energy; %w{music carbs wages facts}[index]; end
  def strength; %w{opinions protein a\ salary rules}[index]; end
  def get_energy; [get, energy].to_phrase; end
  def get_strength; [get, strength].to_phrase; end

  def use; %w{tell go buy imagine}[index]; end
  def use_energy; %w{emote travel pay\ cash guess}[index]; end
  def use_strength; %w{preach clean use\ credit theorize}[index]; end

end
