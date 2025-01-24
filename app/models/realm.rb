class Realm < Concept

  SYMBOL = %w{F S N T}

  ALL = SYMBOL.collect {|symbol| self.new symbol}

  def +(attitude)
    Subtype.all.find{|x| x.attitude == attitude && x.realm == self}
  end

  def subtypes; Subtype.all.select{|x| x.realm == self}; end

  def method_missing(meth, *args, **kwargs, &block)
    [meth.to_s.humanize, name.downcase.wrap].to_phrase
  end

end
