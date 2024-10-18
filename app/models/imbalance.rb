class Imbalance < Concept

  SYMBOL = Problem::SYMBOL.collect do |problem|
            Thing::SYMBOL.collect do |thing|
              problem + thing
          end
        end.flatten

  ALL = SYMBOL.collect {|symbol| self.new symbol}

  def problem; Problem.find_by(symbol.first); end
  def thing; Thing.find_by(symbol.second); end
  def parts; [thing, problem]; end

  def opposite; Problem.find_by(problem.opposite.symbol + thing.symbol); end

  def static; problem.static.gsub('things', thing.static); end


end
