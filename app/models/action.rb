class Action < Concept

  SYMBOL = %w{EP IP IJ EJ } # attitude symbol pairs

  ALL = SYMBOL.collect {|symbol| self.new symbol}
  SYMBOL.each do |sym|
    define_singleton_method(sym) {ALL.find{|s| s.symbol == sym}}
  end

  def +(realm)
    Behavior.all.find{|x| x.realm == realm && x.action == self}
  end


  def behaviors; Behavior.all.select{|x| x.action == self}; end

  def flop_symbol; %w{EJ IJ IP EP}[index]; end
  def flop; Action.find_by(flop_symbol); end

end
