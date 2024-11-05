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
  def peers; tendency.subtypes.without(self); end
  def siblings; thing.subtypes.without(self);end

  %w{problem solution role herring}.each do |string|
    define_method(string) {Behavior.find_by(tendency.send(string + '_key') + thing.symbol)}
  end

  %w{accept change}.each do |string|
    define_method(string) {Behavior.find_by(string.first.capitalize + thing.symbol)}
  end

  def action; inverted? ? change : accept; end
  def behavior; thing + tendency.help; end

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
