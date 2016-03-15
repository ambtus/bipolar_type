class Realm < Indexable

  ########
  IDENTIFIERS = %w{s n f t}
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

  def adjective; choose Adjective, %w{ physical mental social financial}; end
  def adverb; adjective.ly; end
  def name; adjective.titleize; end

  def consume; choose Verb, %w{eat look listen work}; end

  def produce; choose Verb, %w{move guess talk shop}; end
  def produce_with; choose Verb, %w{do solve influence acquire}; end
  def anything; choose Noun, %w{anything anything anyone anything}; end
  def produce_anything; Phrase.new [produce_with, anything]; end
  def things; choose Noun, %w{things problems people possessions}; end
  def produce_things; Phrase.new [produce_with, things]; end
  def produce_more; Phrase.new [produce_with, "more", things]; end
  def produce_too_much; Phrase.new [produce_with, "too many", things]; end

  def potential; choose Noun, %w{fat memories friends savings}; end
  def energy; choose Noun, %w{calories details emotions money}; end

  def worn_out; choose Adjective, %w{sore wrong misunderstood  indebted}; end

  def consume_with_verb; choose Verb, %w{eat look listen handle}; end
  def consume_with_helper; choose Word, %w{NIL at to NIL}; end
  def consume_with; Phrase.optional consume_with_verb, consume_with_helper; end

  def consume_bad_things; Phrase.new [consume_with, resources, "that", appear.string, "bad"]; end
  def consume_the_good_parts; Phrase.new [consume_with, "the", part.pluralize, "that", appear.string, "good"]; end
  def consume_resources; Phrase.new [consume_with, resources]; end
  def consume_anything; Phrase.new [consume_with, "anything"]; end

  def part; choose Noun, %w{ingredient detail voice feature}; end
  def parts; part.pluralize; end
  def resource; choose Noun, %w{meal picture story tool}; end
  def resources; resource.pluralize; end
  def appear; choose Verb, %w{smell look sound feel}; end
  def appearance; choose Verb, %w{smell sight sound touch}; end


  def sick; choose Verb, %w{nauseous afraid ashamed angry};end
  def be_sick_verb; choose Verb, %w{throw panic cry fight};end
  def be_sick_helper; choose Word, %w{up NIL NIL NIL};end
  def be_sick; Phrase.optional be_sick_verb, be_sick_helper; end

end
