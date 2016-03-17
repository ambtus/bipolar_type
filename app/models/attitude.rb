class Attitude < Indexable

  ########
  IDENTIFIERS = %w{ p e i j }
  def self.paths; IDENTIFIERS; end
  ALL = IDENTIFIERS.collect{|letter| self.new letter}
  def self.all; self::ALL; end
  all.each { |i| define_singleton_method(i.path) {all[IDENTIFIERS.index i.string]} }
  ########

  def self.in_order;  ALL.values_at(2,3,0,1); end
  def ordered_index; self.class.in_order.index(self); end

  def +(realm); subtypes.find{|s| s.realm == realm} || Subtype.new([realm, self]); end
  def quad; Quad.new Array.new(4, path).join; end
  def subtypes; Subtype.all.select{|s| s.attitude == self}; end
  Realm.all.each {|r| define_method(a.path) {self + r}}
  def generic_subtype; Subtype.new [Realm.generic, self]; end

  def consumer?; index < 2; end
  def balanced?; [1,2].include? index; end
  def producer?; index.odd?; end

  def ease_of_consumption; consumer? ? "easy" : "hard"; end
  def ease_of_production; producer? ? "easy" : "hard"; end
  def and_or_but; balanced? ? "and" : "but"; end


  def ill; choose Noun, %w{depressed cyclothymic bipolar manic}; end

end
