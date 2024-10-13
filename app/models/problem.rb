class Problem < Concept

  SYMBOL = Mood::SYMBOL.collect do |mood|
             Focus::SYMBOL.collect do |focus|
               Action::SYMBOL.collect do |action|
                mood + focus + action
              end
            end
          end.flatten

  ALL = SYMBOL.collect{|symbol| self.new symbol}

  def mood; Mood.find_by(symbol.first); end
  def focus; Focus.find_by(symbol.second); end
  def action; Action.find_by(symbol.third); end
  def parts; [focus, mood, action]; end # sort_by(&:parts)

  def behavior; Behavior.find_by(symbol.chip); end
  def state; State.find_by(symbol.delete(focus.symbol)); end

  def pair; [state, focus]; end

  def extreme?; state.extreme?; end

end
