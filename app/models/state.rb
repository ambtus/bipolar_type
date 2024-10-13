class State < Concept

  SYMBOL = Mood::SYMBOL.collect do |mood|
            Action::SYMBOL.collect do |action|
              mood + action
          end
        end.flatten

  ALL = SYMBOL.collect {|symbol| self.new symbol}
  def self.sorted; ALL.values_at(0,2,1,3); end

  def mood; Mood.find_by(symbol.first); end
  def action; Action.find_by(symbol.second); end
  def parts; [mood, action]; end


  def extreme?; mood.index == action.index; end

end
