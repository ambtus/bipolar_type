class Attitude < Concept

  SYMBOL = %w{J I E P} # cannot overlap realm symbols

  ALL = SYMBOL.collect {|symbol| self.new symbol}

  def dominant?; [0,3].include?(index); end

  def +(realm)
    Subtype.all.find{|x| x.realm == realm && x.attitude == self}
  end

  def subtypes; Subtype.all.select{|x| x.attitude == self}; end

end
