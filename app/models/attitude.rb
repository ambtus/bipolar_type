class Attitude < Indexable

  ########
  IDENTIFIERS = %w{ ep ej ip ij }
  def self.paths; IDENTIFIERS; end
  ALL = IDENTIFIERS.collect{|letter| self.new letter}
  def self.all; self::ALL; end
  all.each { |i| define_singleton_method(i.path) {all[IDENTIFIERS.index i.string]} }
  ########

  def +(realm); subtypes.find{|s| s.realm == realm} || Subtype.new([realm, self]); end
  def quad; Quad.new Array.new(4, path).join("-"); end
  def subtypes; Subtype.all.select{|s| s.attitude == self}; end
  Realm.all.each {|r| define_method(a.path) {self + r}}
  def generic_subtype; Subtype.new [Realm.generic, self]; end

  def top?; index < 2; end
  def bottom?; index > 1; end
  def right?; index.odd?; end
  def left?; index.even? ; end
  def backslash?; [0,3].include? index; end
  def slash?; [1,2].include? index; end

  def adjective; choose Adjective, %w{fat lazy ungrateful thin}; end
  def name; adjective.titleize; end
end
