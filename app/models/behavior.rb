class Behavior < Concept

  SYMBOL = Help::SYMBOL.collect do |help|
             Thing::SYMBOL.collect do |thing|
               help + thing
            end
          end.flatten

  ALL = SYMBOL.collect{|symbol| self.new symbol}

  def help; Help.find_by(symbol.first); end
  def thing; Thing.find_by(symbol.second); end

  def parts; [help, thing]; end

  def opposite; thing + help.opposite; end

  def method_missing(meth, *args, **kwargs, &block)
    if help.respond_to?(meth)
      help.send(meth, *args)
    elsif thing.respond_to?(meth)
      thing.send(meth, *args)
    else
      super(meth, *args)
    end
  end

end
