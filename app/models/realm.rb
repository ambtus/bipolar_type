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
  def consume_with; consume_helper ? Phrase.new([consume, consume_helper]) : consume; end

  def produce; choose Verb, %w{move talk buy predict}; end
  def produce_with; choose Verb, %w{do say own change}; end

  def unproductive; choose Adjective, %w{seated silent unprovisioned undecided}; end

  def description; Phrase.new [consume, "and", produce]; end

  def empty; choose Adjective, %w{hungry lonely purse-pinched unsure}; end
  def worn_out; choose Adjective, %w{sore misunderstood maxed-out wrong}; end

  def dying; choose Word, %w{starvation suicide destitution fatal\ mistakes}; end

  def strengths; choose Noun, %w{muscles metaphors credit rules}; end
  def kinetics; choose Noun, %w{glycogen emotions cash facts}; end
  def potential; choose Noun, %w{fat attachments savings memories}; end

  def resources; choose Noun, %w{food sounds rewards pictures}; end
  def gain_resources; Phrase.new [consume, consume_helper, resources]; end

  def strengtheners; choose Noun, %w{protein words property patterns}; end
  def obvious; choose Adjective, %w{sweet loud overtime clear}; end
  def energizers; choose Noun, %w{carbs tones wages facts}; end
  def buffers; choose Noun, %w{fat harmony automatic\ savings categories}; end

  def productions
    [Phrase.new([Verb.new("go"), "places and", Verb.new("do"), "things"]),
     Phrase.new([Verb.new("win"), "friends and", Verb.new("influence"), "people"]),
     Phrase.new([Verb.new("obtain"), "basic needs and", Verb.new("pursue"), "pleasure"]),
     Phrase.new([Verb.new("solve"), "problems and", Verb.new("change"), "the future"])
    ][index]
  end
end
