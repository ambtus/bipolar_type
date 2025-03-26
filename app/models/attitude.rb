class Attitude < Concept

  SYMBOL = %w{E P J I} # cannot overlap realm symbols

  ALL = SYMBOL.collect {|symbol| self.new symbol}

  def dominant?; %w{P J}.include?(symbol); end

  def +(realm)
    Subtype.all.find{|x| x.realm == realm && x.attitude == self}
  end

  def subtypes; Subtype.all.select{|x| x.attitude == self}; end

end
