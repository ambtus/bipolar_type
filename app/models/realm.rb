class Realm < Concept

  SYMBOL = %i{F S T N }

  ALL = SYMBOL.collect {|symbol| self.new symbol}
  SYMBOL.each do |sym|
    define_singleton_method(sym) {ALL.find{|s| s.symbol == sym}}
  end

  def subtypes; Subtype.all.select{|x| x.realm == self}; end
  def +(attitude); subtypes.find{|x| x.attitude == attitude}; end

end
