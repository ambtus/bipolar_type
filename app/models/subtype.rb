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

  %w{problem solution role herring}.each do |string|
    define_method(string) {tendency.send(string + '_key') + thing.symbol}
  end

  def opposite; thing + tendency.opposite; end
  def flip; thing + tendency.flip; end

  def generic_words; [verb, 'too many', thing.symbol, 'things'].to_phrase; end

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
