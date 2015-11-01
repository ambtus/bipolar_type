# Encoding: utf-8
class Quad
  def self.my_path; "fntsp"; end
  def self.first; Quad.new(my_path); end

  def initialize(letters)
    @path = letters
  end
  attr_reader :path

  def pair1; Pair.find(path[2,3]); end
  def p?; pair1.p?; end
  def pair2_end; p? ? "j" : "p"; end
  def pair2; Pair.find(path[0,2] + pair2_end); end
  def pairs; [pair1, pair2]; end
  def name; pairs.map(&:name).join(", "); end
  def subtypes; pairs.map(&:subtypes).flatten; end
  def advice; pairs.map(&:advice).join(", "); end

  def flipped_path; pairs.first.path.chop + pairs.second.path; end
  def flipped; Quad.new(flipped_path); end

  def reversed_pairs; pairs.map(&:reversed); end
  def reversed_path; reversed_pairs.first.path.chop + reversed_pairs.second.path; end
  def reversed; Quad.new(reversed_path); end

  def swapped_path; path.first + path.third + path.second + path.fourth + path.last; end
  def swapped; Quad.new(swapped_path); end
  def swapped_pairs; swapped.pairs; end

  def opposite_path; p? ? path.chop + "j" : path.chop + "p"; end
  def opposite; Quad.new(opposite_path); end
end

