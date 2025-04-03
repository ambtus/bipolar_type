class Attitude < Concept

  SYMBOL = %w{P J I E } # cannot overlap realm symbols

  ALL = SYMBOL.collect {|symbol| self.new symbol}
  SYMBOL.each do |sym|
    define_singleton_method(sym) {ALL.find{|s| s.symbol == sym}}
  end

  def dominant?; %w{P J}.include?(symbol); end

  def +(realm)
    Subtype.all.find{|x| x.realm == realm && x.attitude == self}
  end

  def subtypes; Subtype.all.select{|x| x.attitude == self}; end

  def opposite_symbol; %w{J P E I }[index]; end
  def opposite; Attitude.find_by(opposite_symbol); end

end
