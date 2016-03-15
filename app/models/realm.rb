class Realm < Indexable

  ########
  IDENTIFIERS = %w{g v a t}
  def self.paths; IDENTIFIERS; end
  ALL = IDENTIFIERS.collect{|letter| self.new letter}
  all.each { |r| define_singleton_method(r.path) {all[IDENTIFIERS.index r.string]} }
  ########

  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  def quad; Quad.new Array.new(4, path).join; end
  def +(attitude)
    subtypes.find{|s| s.attitude == attitude} || Subtype.new([self, attitude])
  end
  Attitude.all.each {|a| define_method(a.path) {self + a}}
  def generic_subtype; Subtype.new [self, Attitude.generic]; end

  def adjective; choose Adjective, %w{ gustatory visual auditory tactile}; end
  def adverb; adjective.ly; end
  def name; adjective.titleize; end

  def consume; choose Verb, %w{eat look listen work}; end
  def consume_with_verb; choose Verb, %w{eat look listen handle}; end
  def consume_with_helper; choose Word, %w{NIL at to NIL}; end
  def consume_with; Phrase.optional consume_with_verb, consume_with_helper; end
  def resource; choose Noun, %w{meal picture story tool}; end
  def resources; resource.pluralize; end

  def potential; choose Noun, %w{fat memories friends savings}; end

  def produce; choose Verb, %w{move guess talk shop}; end
  def produce_with; choose Verb, %w{do solve influence acquire}; end
  def things; choose Noun, %w{things problems people possessions}; end
  def worn_out; choose Adjective, %w{sore wrong misunderstood  indebted}; end

  def appear; choose Verb, %w{smell look sound feel}; end
  def appearance; choose Verb, %w{smell sight sound touch}; end

  def sick; choose Verb, %w{nauseous afraid ashamed angry};end
  def be_sick_verb; choose Verb, %w{throw panic cry fight};end
  def be_sick_helper; choose Word, %w{up NIL NIL NIL};end
  def be_sick; Phrase.optional be_sick_verb, be_sick_helper; end

end
