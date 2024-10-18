class State < Concept

  SYMBOL = Problem::SYMBOL.collect do |problem|
            Action::SYMBOL.collect do |action|
              problem + action
          end
        end.flatten

  ALL = SYMBOL.collect {|symbol| self.new symbol}
  def self.sorted; ALL.values_at(0,2,1,3); end

  def problem; Problem.find_by(symbol.first); end
  def action; Action.find_by(symbol.second); end
  def parts; [problem, action]; end


  def extreme?; problem.index == action.index; end

end
