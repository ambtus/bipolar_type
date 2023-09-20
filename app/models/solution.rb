class Solution < Concept

  def initialize(string)
    @symbol = string
    @verb = Verb.send(string.first)
    @determiner = Determiner.send(string.second)
    @realm = Realm.send(string.third)
  end
  attr_reader :symbol, :verb, :realm, :determiner

  def generic_solution; @verb + @determiner; end

  ########
  ALL = GenericSolution::SYMBOLS.collect do |phrase|
          Realm::SYMBOLS.collect do |realm|
            self.new [phrase, realm].join
          end
        end.flatten
  SYMBOLS = ALL.map(&:symbol)
  SYMBOLS.each {|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  ########

  def <=>(solution); self.generic_solution.index <=> solution.generic_solution.index; end

  def focus; verb.focus; end

  def words; [verb, determiner, realm, focus].map(&:word).to_phrase; end

  def problem; realm.send(generic_solution.problem); end
  def state; generic_solution.state; end
  def ability; generic_solution.ability; end

  def problem_behavior; realm.send(generic_solution.problem_behavior); end

end
