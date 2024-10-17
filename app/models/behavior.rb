class Behavior < Concept

  SYMBOL = Focus::SYMBOL.collect do |focus|
            Action::SYMBOL.collect do |action|
              focus + action
          end
        end.flatten

  ALL = SYMBOL.collect {|symbol| self.new symbol}

  def focus; Focus.find_by(symbol.first); end
  def action; Action.find_by(symbol.second); end
  def parts; [focus, action]; end

  def opposite; Behavior.find_by(focus.symbol + action.opposite.symbol); end


end
