class Attitude < Indexable

  ########
  IDENTIFIERS = %w{ p e j i }
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

  def big?; index < 2; end
  def strong?; [1,2].include? index; end
  def balanced?; index.odd?; end

  def big; big? ? "fat" : "thin"; end
  def strong; strong? ? "strong" : "weak"; end
  def conjunction; balanced? ? "and" : "but"; end

  def description; Phrase.new [big, conjunction, strong]; end
  def name; Phrase.new [big.capitalize, conjunction, strong.capitalize]; end

  def sick; choose Noun, %w{depressed cyclothymic manic bipolar}; end
  def illness; choose Noun, %w{depression cyclothymia mania manic\ depression}; end

end
