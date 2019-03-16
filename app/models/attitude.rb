class Attitude < Concept

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


  def act; %w{reject splurge binge stall}[index]; end
  def action; %w{rejection splurge binge stall}[index]; end
  def name; action.capitalize; end

  def surplus?; %w{binge stall}.include?(action); end
  def input?; %w{binge rejection}.include?(action); end
  def pain?; %w{stall rejection}.include?(action); end

  def opposite; others.find{|x| x.input? != self.input? && x.surplus? != self.surplus?}; end

  def preposition; "on" if index > 0; end
  def preference; pain? ? "want to" : "do not want to"; end

  def drugs; surplus? ? "stimulants" : "sedatives"; end
end
