class Problem < Concept

  SYMBOL = Mood::SYMBOL.collect do |mood|
             Focus::SYMBOL.collect do |focus|
               Should::SYMBOL.collect do |should|
                mood + focus + should
              end
            end
          end.flatten

  ALL = SYMBOL.collect{|symbol| self.new symbol}

  def mood; Mood.find_by(symbol.first); end
  def focus; Focus.find_by(symbol.second); end
  def should; Should.find_by(symbol.third); end
  def parts; [phase, focus]; end # sort_by(&:parts) sorts focus last

  def behavior; Behavior.find_by(symbol.chip); end
  def phase; Phase.find_by(symbol.delete(focus.symbol)); end

  def more_or_less; phase.extreme? ? 'more' : 'less'; end
  def cannot; phase.extreme? ? 'cannot' : 'must' ; end
  def hard_or_easy; phase.extreme? ? 'hard' : 'easy' ; end

end
