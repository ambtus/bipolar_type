class State < Concept

  SYMBOL = Imbalance::SYMBOL.collect do |imbalance|
            Action::SYMBOL.collect do |action|
              imbalance + action
          end
        end.flatten

  ALL = SYMBOL.collect {|symbol| self.new symbol}
  def self.sorted; ALL.values_at(0,2,1,3); end

  def imbalance; Imbalance.find_by(symbol.first); end
  def action; Action.find_by(symbol.second); end
  def parts; [imbalance, action]; end


  def extreme?; imbalance.index == action.index; end

end
