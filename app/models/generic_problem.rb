class GenericProblem < Concept

  def initialize(string)
    @symbol = string
    @attitude = Attitude.send(string.first)
    @state = State.send(string.second)
  end
  attr_reader :symbol, :attitude, :state

  ########
  SYMBOLS = %w{UM DM DD UD}
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each {|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  ########

  def problems; Problem.all.select{|b| b.generic_problem == self}; end

  def words; [attitude, state].map(&:word).to_phrase; end

end
