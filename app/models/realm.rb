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

  def domain; choose Adjective, %w{physical spiritual material mental}; end
  def domainly; domain.ly; end
  def name; Phrase.new [domain.titleize, parenthesize]; end

  def consume; choose Verb, %w{eat listen earn look}; end
  def consume_helper; choose Word, %w{NIL to NIL at}; end
  def produce; choose Verb, %w{move talk spend predict}; end

  def empty; choose Adjective, %w{hungry guilty purse-pinched unsure}; end
  def worn_out; choose Adjective, %w{sore misunderstood maxed-out wrong}; end

  def strengths; choose Noun, %w{muscles metaphors credit rules}; end
  def potential; choose Noun, %w{fat egotism savings trivia}; end

  def strengtheners; choose Noun, %w{protein words repayments patterns}; end
  def energizers; choose Noun, %w{carbs tones cash facts}; end
  def buffers; choose Noun, %w{fat harmony automatic\ savings categories}; end

end
