class Realm < Indexable

  ########
  IDENTIFIERS = %w{sf nt st nf}
  def self.paths; IDENTIFIERS; end
  ALL = IDENTIFIERS.collect{|letter| self.new letter}
  all.each { |r| define_singleton_method(r.path) {all[IDENTIFIERS.index r.string]} }
  ########


  def +(attitude); subtypes.find{|s| s.attitude == attitude} || Subtype.new([self, attitude]); end
  def quad; Quad.new Array.new(4, path).join("-"); end
  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  Attitude.all.each {|a| define_method(a.path) {self + a}}
  def generic_subtype; Subtype.new [self, Attitude.generic]; end

  def adjective; choose Noun, %w{physical mental material spiritual }; end
  def name; adjective.capitalize; end

  def consume; choose Verb, %w{eat believe use hear }; end
  def resources; choose Noun, %w{meals theories tools stories }; end
  def buffer; choose Verb, %w{sweeten whitewash smooth soften }; end
  def interesting; choose Adjective, %w{bitter ugly rough loud }; end
  def parts; choose Noun, %w{ingredients truths edges whines }; end

end
