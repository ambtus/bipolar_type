class Pair

  def initialize(array,bool=true)
    @controlled = bool
    raise "#{bool} is not a Boolean" unless [true, false].include? @controlled
    raise "#{array} is not an array" unless array.respond_to?(:to_ary)
    raise "#{array} is not a pair of (un)controlled subtypes" unless array.size == 2
    @subtypes = array
    raise "#{array} is not a pair of subtypes" unless @subtypes.all?{|x| x.is_a? Subtype}
  end
  attr_reader :subtypes

  def <=>(other); subtypes <=> other.subtypes; end

  def prefix; @controlled ? "Controlled " : "Uncontrolled "; end

  def names; name.to_word(" & ").prefix(prefix); end
  alias_method :inspect, :names

  def mbtiish; first.function.wrap(second.function); end

  def method_missing(meth, *arguments, &block)
    if Subtype.method_defined?(meth)
      @subtypes.collect{|s| s.send(meth)}
    else
      @subtypes.send(meth, *arguments, &block)
    end
  end

end
