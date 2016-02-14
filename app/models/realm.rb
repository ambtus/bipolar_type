class Realm < Indexable

  ########
  IDENTIFIERS = %w{ mental financial physical emotional}
  def self.paths; IDENTIFIERS; end
  ALL = IDENTIFIERS.collect{|letter| self.new letter}
  all.each { |r| define_singleton_method(r.path) {all[IDENTIFIERS.index r.string]} }
  ########

  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  def quad; Quad.new Array.new(4, path).join("-"); end
  def +(attitude)
    subtypes.find{|s| s.attitude == attitude} || Subtype.new([self, attitude])
  end
  Attitude.all.each {|a| define_method(a.path) {self + a}}
  def generic_subtype; Subtype.new [self, Attitude.generic]; end

  def identifier; choose Adjective, IDENTIFIERS; end
  def name; identifier.titleize; end

  def consume; choose Verb, %w{see earn eat hear}; end
  def energy; choose Noun, %w{results rewards calories emotions}; end
  def produce; choose Verb, %w{predict spend burn express}; end

  def empty; choose Noun, %w{art winnings sweets music}; end
  def appear; choose Verb, %w{looks feel taste sounds}; end

end
