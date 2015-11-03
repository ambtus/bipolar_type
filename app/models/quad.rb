# Encoding: utf-8
class Quad
  def self.my_path; "entinfisjisp"; end
  def self.first; Quad.new(my_path); end

  def initialize(letters)
    @path = letters
  end
  attr_reader :path

  def paths; path.scan(/....../).reverse; end
  def pairs; paths.collect{|p| Pair.find(p)}; end
  def name; pairs.map(&:name).join(", "); end
  def advices; pairs.map(&:advices).flatten; end

  def subtypes; pairs.map(&:subtypes).flatten; end
  def flipped; Quad.new(paths.join); end
  def reversed; Quad.new(pairs.map(&:reverse).map(&:path).join); end
  def swapped; Quad.new(path[6,3] + path[3,3] + path[0,3] + path[9,3]); end
  def opposite; Quad.new(pairs.map(&:opposite).reverse.map(&:path).join); end
end
