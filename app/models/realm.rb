class Realm < Indexable

  ########
  LETTERS = %w{S F T N}
  ALL = LETTERS.collect{|letter| self.new letter}
  all.each { |r| define_singleton_method(r.path) {all[LETTERS.index r.string]} }
  ########

  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  def +(attitude)
    subtypes.find{|s| s.attitude == attitude} || Subtype.new([self, attitude])
  end
  Attitude.all.each {|a| define_method(a.path) {self + a}}

  def domain; choose Adjective, %w{physical social financial mental}; end
  def domainly; domain.ly; end
  def name; Phrase.new [domain.titleize, parenthesize]; end

  def consume; choose Verb, %w{eat listen earn look}; end
  def consume_helper; choose Word, %w{NIL to NIL at}; end

  def produce; choose Verb, %w{move talk buy predict}; end
  def produce_with; choose Verb, %w{do say own guess}; end

  def unproductive; choose Adjective, %w{seated silent unprovisioned undecided}; end

  def description; Phrase.new [consume, "and", produce]; end

  def empty; choose Adjective, %w{hungry lonely purse-pinched unsure}; end
  def worn_out; choose Adjective, %w{sore misunderstood maxed-out wrong}; end

  def strengths; choose Noun, %w{muscles metaphors credit rules}; end
  def kinetics; choose Noun, %w{glycogen emotions cash facts}; end
  def potential; choose Noun, %w{fat attachments savings generalizations}; end

  def resources; choose Noun, %w{food sounds rewards pictures}; end
  def gain_resources; Phrase.new [consume, consume_helper, resources]; end

  def strengtheners; choose Noun, %w{protein words property patterns}; end
  def energizers; choose Noun, %w{carbs intonation wages details}; end
  def buffers; choose Noun, %w{fat harmony automatic\ savings categories}; end

  def productions
    ["go places and do things",
     "win friends and influence people",
     "obtain basic needs and pursue pleasure",
     "solve problems and change the future"][index].to_phrase
  end
end
