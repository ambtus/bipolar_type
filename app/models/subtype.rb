class Subtype < Concept

  SYMBOL = Thing::SYMBOL.collect do |thing|
             Tendency::SYMBOL.collect do |tendency|
                tendency.first + thing + tendency.second
            end
          end.flatten

  ALL = SYMBOL.collect{|symbol| self.new symbol}

  def thing; Thing.find_by(symbol.second); end
  def tendency; Tendency.find_by(symbol.delete(thing.symbol)); end

  def parts; [tendency, thing]; end

  def problem_key; thing.symbol + tendency.problem_key; end
  def solution_key; thing.symbol + tendency.solution_key; end

  def opposite; thing + tendency.opposite; end

  def method_missing(meth, *args, **kwargs, &block)
    if tendency.respond_to?(meth)
      tendency.send(meth)
    elsif tendency.help.respond_to?(meth)
      tendency.help.send(meth)
    else
      super(meth)
    end
  end

end
