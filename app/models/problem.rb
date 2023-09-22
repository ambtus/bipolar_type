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

  def words; [realm.word, generic_problem.imbalance].to_phrase; end

  def solutions; Solution.all.select{|s| s.problem == self}; end

end
