class Problem < Concept

  def initialize(string)
    @symbol = string
    @realm = Realm.send(string.first)
    @generic_problem = GenericProblem.send(string.second)
  end
  attr_reader :symbol, :realm, :generic_problem

  ########
  ALL = Realm::SYMBOLS.collect do |realm|
          GenericProblem::SYMBOLS.collect do |imbalance|
            self.new [realm, imbalance].join
          end
        end.flatten
  SYMBOLS = ALL.map(&:symbol)
  SYMBOLS.each {|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  ########

  def words; [realm, generic_problem].map(&:word).to_phrase; end

  def <=>(other); self.generic_problem.index <=> other.generic_problem.index; end

end
