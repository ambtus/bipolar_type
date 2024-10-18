class Solution < Concept

  SYMBOL = Problem::SYMBOL.collect do |problem|
             Thing::SYMBOL.collect do |thing|
               Action::SYMBOL.collect do |action|
                problem + thing + action
              end
            end
          end.flatten

  ALL = SYMBOL.collect{|symbol| self.new symbol}

  def problem; Problem.find_by(symbol.first); end
  def thing; Thing.find_by(symbol.second); end
  def action; Action.find_by(symbol.third); end
  def parts; [problem, thing, action]; end # sort_by(&:parts)

  def behavior; Behavior.find_by(symbol.chip); end
  def state; State.find_by(symbol.delete(thing.symbol)); end
  def imbalance; Imbalance.find_by(symbol.chop);end

  def pair; [state, thing]; end

  def extreme?; state.extreme?; end
  def drugs; problem.drugs; end

  def static
    [thing.static, 'are', extreme? ? 'very' : 'somewhat', problem.adjective].to_phrase
  end

end
