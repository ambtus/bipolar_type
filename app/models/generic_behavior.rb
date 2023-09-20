class GenericBehavior < Concept

  def initialize(string)
    @symbol = string
    @verb = Verb.send(string.first)
    @noun = Noun.send(string.second)
  end
  attr_reader :symbol, :verb, :noun

  ########
  SYMBOLS = %w{GS GE UE US}
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each {|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  ########

  def behaviors; Behavior.all.select{|b| b.generic_behavior == self}; end

  def words; [verb.word, noun.word].to_phrase; end
  def underscored; words.gsub(" ", '_'); end

end
