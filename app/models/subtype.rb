class Subtype < Concept

  SYMBOL = Thing::SYMBOL.collect do |thing|
             Tendency::SYMBOL.collect do |tendency|
                tendency.first + thing + tendency.second
            end
          end.flatten

  ALL = SYMBOL.collect{|symbol| self.new symbol}

  def thing; Thing.find_by(symbol.second); end
  def tendency; Tendency.find_by(symbol.delete(thing.symbol)); end

  def pair; [tendency, thing]; end

  def key; thing.symbol + tendency.key; end

  def opposite; thing + tendency.opposite; end
  def flop; thing + tendency.flop; end
  def flip; thing + tendency.flip; end

end
