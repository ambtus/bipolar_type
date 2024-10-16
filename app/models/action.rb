class Action < Concept

  SYMBOL = Focus::SYMBOL.collect do |focus|
            Behavior::SYMBOL.collect do |behavior|
              focus + behavior
          end
        end.flatten

  ALL = SYMBOL.collect {|symbol| self.new symbol}

  def focus; Focus.find_by(symbol.first); end
  def behavior; Behavior.find_by(symbol.second); end
  def parts; [focus, behavior]; end

  def opposite; Action.find_by(focus.symbol + behavior.opposite.symbol); end


end
