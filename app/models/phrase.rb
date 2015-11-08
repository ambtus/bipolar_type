class Phrase

  def initialize(array)
    raise "#{array} is not an array" unless array.respond_to?(:to_ary)
    raise "#{array} is not an array of words" if array.empty?
    raise "#{array} is not an array of words" unless array.all?{|x| x.respond_to?(:to_word)}
    @array = array.map(&:to_word)
  end
  def words; @array; end

  def inspect; words.join("•"); end
  def to_s; words.join(" "); end
  def fewer_phrase; @array.unshift(words.last.fewer); end
  %w{ing ed en}.each {|verb_suffix| define_method(verb_suffix) {(@array[0] = first.send(verb_suffix)) && (return self)}}

  def method_missing(meth, *arguments, &block)
    if Word.method_defined?(meth)
      @array[-1] = words.last.send(meth)
      return self
    else
      @array.send(meth, *arguments, &block)
    end
  end

end
