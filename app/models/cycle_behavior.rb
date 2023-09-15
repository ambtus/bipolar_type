class CycleBehavior < Concept

  def initialize(string)
    raise "#{string} length is not 2" unless string.length == 2
    @symbol = string
    @cycle = Cycle.send(symbol.first)
    @cycle_type = CycleType.send(symbol.second)
  end
  attr_reader :symbol, :cycle, :cycle_type

  ########
  SYMBOLS = %w{GE GS UE US}
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each {|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  ########

  def self.all; ALL; end
  def self.first; ALL.first; end
  ALL.each{|s| define_singleton_method(s.symbol) {s}}

  def index; ALL.index self; end

  def behaviors; Behavior.all.select{|s| s.cycle == @cycle && s.cycle_type == @cycle_type}; end
  def +(realm); Behavior.find{|s| s.realm == realm}; end

  def method_missing(meth, *arguments, &block)
    if cycle.respond_to?(meth)
      cycle.send(meth, *arguments, &block)
    elsif cycle_type.respond_to?(meth)
      cycle_type.send(meth, *arguments, &block)
    else
      super
    end
  end

  def description; [verb, noun].to_phrase; end
  def name;[verb, noun].map(&:capitalize).to_phrase;end

end
