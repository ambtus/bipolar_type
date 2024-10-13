class Balance < Concept

  SYMBOL = Mood::SYMBOL.collect do |mood|
            Focus::SYMBOL.collect do |focus|
              mood + focus
          end
        end.flatten

  ALL = SYMBOL.collect {|symbol| self.new symbol}

  def mood; Mood.find_by(symbol.first); end
  def focus; Focus.find_by(symbol.second); end
  def parts; [focus, mood]; end

  def opposite; Balance.find_by(mood.opposite.symbol + focus.symbol); end


end
