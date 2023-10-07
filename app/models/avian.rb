class Avian < Concept

  def initialize(string); @symbol = string; end
  attr_reader :symbol

  ########
  SYMBOLS = %w{E B A N O}
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each{|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  ########

  def self.average; self::ALL[2]; end

  def self.derive_from(realms)
    string = realms.map(&:symbol).join
    if string.without('PA') == 'MF'
      string.first == 'M' ? 'EE': 'BB'
    elsif string.without('PA') == 'FM'
      string.first == 'F' ? 'OO' : 'NN'
    else
      'AA'
    end
  end

  def first; %w{early night average early night}[index]; end
  def second; %w{bird bird avian owl owl}[index]; end
  def words; [first, second].to_phrase; end

end
