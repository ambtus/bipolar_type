class Attitude < Indexable

  ########
  IDENTIFIERS = %w{ i j e p }
  def self.paths; IDENTIFIERS; end
  ALL = IDENTIFIERS.collect{|letter| self.new letter}
  def self.all; self::ALL; end
  all.each { |i| define_singleton_method(i.path) {all[IDENTIFIERS.index i.string]} }
  ########

  def +(realm)
    subtypes.find{|s| s.realm == realm} || Subtype.new([realm, self])
  end

  def quad; Quad.new Array.new(4, path).join; end

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end

  def middle?; [1,2].include? index; end
  def left?; index < 2; end
  def even?; index.even? ; end
  def sensitivity; left? ? "sensitive" : "insensitive"; end
  def behavior; middle? ? "producer" : "consumer"; end
  def description; Phrase.new [sensitivity, behavior]; end
  def name; description.titleize; end

end
