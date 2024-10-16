class Problem < Concept

  SYMBOL = Imbalance::SYMBOL.collect do |imbalance|
            Focus::SYMBOL.collect do |focus|
              imbalance + focus
          end
        end.flatten

  ALL = SYMBOL.collect {|symbol| self.new symbol}

  def imbalance; Imbalance.find_by(symbol.first); end
  def focus; Focus.find_by(symbol.second); end
  def parts; [focus, imbalance]; end

  def opposite; Imbalance.find_by(imbalance.opposite.symbol + focus.symbol); end


end
