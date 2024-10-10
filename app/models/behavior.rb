class Behavior < Concept

  SYMBOL = Focus::SYMBOL.collect do |focus|
            Should::SYMBOL.collect do |should|
              focus + should
          end
        end.flatten

  ALL = SYMBOL.collect {|symbol| self.new symbol}

  def focus; Focus.find_by(symbol.first); end
  def should; Should.find_by(symbol.second); end
  def parts; [focus, should]; end


end
