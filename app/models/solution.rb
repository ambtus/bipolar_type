class Solution < Concept

  SYMBOL = Imbalance::SYMBOL.collect do |imbalance|
             Focus::SYMBOL.collect do |focus|
               Action::SYMBOL.collect do |action|
                imbalance + focus + action
              end
            end
          end.flatten

  ALL = SYMBOL.collect{|symbol| self.new symbol}

  def imbalance; Imbalance.find_by(symbol.first); end
  def focus; Focus.find_by(symbol.second); end
  def action; Action.find_by(symbol.third); end
  def parts; [imbalance, focus, action]; end # sort_by(&:parts)

  def behavior; Behavior.find_by(symbol.chip); end
  def state; State.find_by(symbol.delete(focus.symbol)); end
  def problem; Problem.find_by(symbol.chop);end

  def pair; [state, focus]; end

  def extreme?; state.extreme?; end
  def drugs; imbalance.drugs; end

  def more; extreme? ? 'more' : 'less'; end

end
