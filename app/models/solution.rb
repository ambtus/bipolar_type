class Solution < Concept

  def initialize(string)
    raise "#{string} length is not 2" unless string.length == 2
    @symbol = string
    @nature = Nature.send(symbol.first)
    @nurture = Nurture.send(symbol.second)
  end
  attr_reader :symbol, :nature, :nurture

  ########
  SYMBOLS = %w{PD WD WS PS}
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each {|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  ########

  def self.all; ALL; end
  def self.first; ALL.first; end
  ALL.each{|s| define_singleton_method(s.symbol) {s}}

  def index; ALL.index self; end

  def subtypes; Subtype.all.select{|s| s.nature == @nature && s.nurture == @nurture}; end
  def +(realm); subtypes.find{|s| s.realm == realm}; end

  def method_missing(meth, *arguments, &block)
    if nurture.respond_to?(meth)
      nurture.send(meth, *arguments, &block)
    elsif nature.respond_to?(meth)
      nature.send(meth, *arguments, &block)
    else
      super
    end
  end

  def description; [attitude, problem].to_phrase; end

  def siblings; attitude.subtypes + nurture.subtypes - [self]; end

  def types; Type.all.select{|t| t.subtypes.include?(self)}; end


end
