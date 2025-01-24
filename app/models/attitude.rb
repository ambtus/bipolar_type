class Attitude < Concept

  SYMBOL = %w{J P M D} # cannot overlap realm symbols

  ALL = SYMBOL.collect {|symbol| self.new symbol}

  def dominant?; index < 2; end

  def +(realm)
    Subtype.all.find{|x| x.realm == realm && x.attitude == self}
  end

  def subtypes; Subtype.all.select{|x| x.attitude == self}; end

  def method_missing(meth, *args, **kwargs, &block)
    [meth.to_s.humanize, name.downcase.wrap].to_phrase
  end

end
