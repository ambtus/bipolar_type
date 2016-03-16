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

  def adjective; choose Adjective, %w{ gustatory visual auditory tactile}; end
  def adverb; adjective.ly; end
  def name; adjective.titleize; end

  def generic; choose Adjective, %w{ physical mental emotional financial}; end

  def consume; choose Verb, %w{eat look listen work}; end
  def consume_alt; choose Verb, %w{eat see hear earn}; end
  def consume_with_verb; choose Verb, %w{eat look listen do}; end
  def consume_with_helper; choose Word, %w{NIL at to NIL}; end
  def consume_with; Phrase.optional consume_with_verb, consume_with_helper; end
  def part; choose Noun, %w{food color voice task}; end
  def parts; part.pluralize; end
  def resource; choose Noun, %w{meal picture story job}; end
  def resources; resource.pluralize; end

  def stop; choose Verb, %w{leave close turn put}; end
  def the; choose Word, %w{the your off\ the down\ the}; end
  def stimulation; choose Noun, %w{kitchen eyes sound tools}; end
  def turn_off; Phrase.new [stop, the, stimulation] ; end

  def increase; choose Verb, %w{add turn turn take}; end
  def your; choose Word, %w{some on\ some up\ the some}; end
  def stimuli; choose Noun, %w{spices lights volume risks}; end
  def turn_on; Phrase.new [increase, your, stimuli] ; end



  def energy; choose Noun, %w{food details intonation rewards}; end

  def potential; choose Noun, %w{fat memories friends savings}; end
  def fat; choose Adjective, %w{fat trivial connected rich}; end
  def thin; choose Adjective, %w{skinny theoretical isolated poor}; end

  def produce; choose Verb, %w{walk guess talk shop}; end
  def produce_alt; choose Verb, %w{do predict say buy}; end
  def produce_with; choose Verb, %w{do solve influence acquire}; end
  def thing; choose Noun, %w{thing problem person possession}; end
  def things; thing.pluralize; end
  def nothing; third? ? "nobody" : "nothing"; end

  def worn_out; choose Adjective, %w{sore wrong misunderstood  indebted}; end

  def organ; choose Noun, %w{nose eyes ears fingers}; end
  def appear; choose Verb, %w{taste look sound feel}; end
  def appears; appear.s; end
  def appearance; choose Noun, %w{smell sight sound touch}; end
  def appearances; appearance.pluralize; end
  def bad; choose Adjective, %w{bitter ugly whiny difficult }; end
  def good; choose Adjective, %w{sweet symmetric harmonious easy}; end
  def obvious; choose Adjective, %w{fragrant bright loud painful}; end
  def subtle; choose Adjective, %w{bland pastel soft repetitive }; end

  def sick; choose Verb, %w{nauseous afraid ashamed angry};end
  def be_sick_verb; choose Verb, %w{throw panic cry fight};end
  def be_sick_helper; choose Word, %w{up NIL NIL NIL};end
  def be_sick; Phrase.optional be_sick_verb, be_sick_helper; end

end
