# Encoding: utf-8
class Quad
  def self.my_path; "espitjifp"; end
  def self.first; Quad.find(my_path); end

  # yes, there's got to be a better way, but this works
  # and it only has to run once on startup
  LETTERS = Pair.all.collect{|pair| pair.potentials.collect {|potential| pair.path + potential.path}}.flatten

  def initialize(letters)
    @path = letters
    @index = LETTERS.index(letters)
  end
  attr_reader :path

  QUADS = LETTERS.collect{|letters| Quad.new(letters)}
  def self.find(letters); QUADS[LETTERS.index(letters)]; end
  def self.all; QUADS; end

  def ss; path.scan(/.../).collect{|p| Subtype.find(p)}; end
  def inferior; ss.first; end
  def tertiary; ss.second; end
  def dominant; ss.third; end

  def realms; ss.map(&:realm); end
  def secondary_realm; (Realm.all - realms).first; end

  def secondary; dominant.potentials.find{|s| s.realm == secondary_realm}; end

  def subtypes; (ss + [secondary]).sort_by{|s| [s.sensitivity.index, s.attitude.index]}; end

  def pair; Pair.find(path[0,6]); end

  def dominant_state; dominant.goal; end
  def secondary_state; secondary.too; end
  def second_pair_name; [secondary_state, dominant_state].map(&:capitalize).join(" and "); end
  def name; [pair.name, second_pair_name].join(", "); end

end
