class Attitude < Concept

  SYMBOL = %i{P I J E } # cannot overlap realm symbols

  ALL = SYMBOL.collect {|symbol| self.new symbol}
  SYMBOL.each do |sym|
    define_singleton_method(sym) {ALL.find{|s| s.symbol == sym}}
  end

  def next; self.class.rotate[index]; end
  def previous; self.class.rotate(-1)[index]; end
  def opposite; self.class.rotate(2)[index]; end

  def dominant?; %i{P J}.include?(symbol); end

  def subtypes; Subtype.all.select{|x| x.attitude == self}; end
  def +(realm); subtypes.find{|x| x.realm == realm}; end

end
