class Attitude < Indexable

  ########
  IDENTIFIERS = %w{ ➡ ⬇ ⬆ ⬅  }
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

  def self.in_order; ALL.values_at(0,1,3,2); end

  def insensitive?; index < 2; end
  def sensitive?; index > 1; end
  def producer?; index.odd?; end
  def consumer?; index.even? ; end
  def bipolar?; [0,3].include? index; end
  def cyclothymic?; [1,2].include? index; end

  def adjective; choose Adjective, %w{ slow bored strong weak}; end
  def name; adjective.titleize; end
end
