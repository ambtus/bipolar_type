class State < Concept

  SYMBOL = Imbalance::SYMBOL.collect do |imbalance|
            Behavior::SYMBOL.collect do |behavior|
              imbalance + behavior
          end
        end.flatten

  ALL = SYMBOL.collect {|symbol| self.new symbol}
  def self.sorted; ALL.values_at(0,2,1,3); end

  def imbalance; Imbalance.find_by(symbol.first); end
  def behavior; Behavior.find_by(symbol.second); end
  def parts; [imbalance, behavior]; end


  def extreme?; imbalance.index == behavior.index; end

end
