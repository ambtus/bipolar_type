class Realm < Indexable

  ########
  IDENTIFIERS = %w{ physical mental social financial }
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

  def adjective; choose Adjective, IDENTIFIERS; end
  def adverb; adjective.ly; end
  def name; adjective.titleize; end

  def consume; choose Verb, %w{eat believe understand earn }; end
  def resources; choose Noun, %w{food light stories rewards }; end

  def triggers; choose Noun, %w{carbs red music cash }; end
  def buffers; choose Noun, %w{fat green rhythm repayments  }; end
  def strengtheners; choose Noun, %w{protein purple words credit }; end

  def produce; choose Verb, %w{do predict say buy}; end

  def potential; choose Noun, %w{fat hope shame savings }; end

end
