class Behavior < Concept

  SYMBOL = Thing::SYMBOL.collect do |thing|
            Action::SYMBOL.collect do |action|
              thing + action
          end
        end.flatten

  ALL = SYMBOL.collect {|symbol| self.new symbol}

  def thing; Thing.find_by(symbol.first); end
  def action; Action.find_by(symbol.second); end
  def parts; [thing, action]; end

  def opposite; Behavior.find_by(thing.symbol + action.opposite.symbol); end

  def static; action.static.gsub('things', thing.static); end


end
