class Realm < Indexable

  ########
  LETTERS = %w{S F T N}
  ALL = LETTERS.collect{|letter| self.new letter}
  all.each { |r| define_singleton_method(r.path) {all[LETTERS.index r.string]} }
  ########

  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  def +(attitude); subtypes.find{|s| s.attitude == attitude}; end
  Attitude.all.each {|a| define_method(a.path) {self + a}}

  def domain; choose Adjective, %w{gustatory auditory tactile visual}; end
  #def name; Phrase.new [domain.titleize, parenthesize]; end
  #def name; domain.titleize; end
  def sense; choose Noun, %w{taste/smell hearing touch/pain sight}; end
  def neuro; choose Noun, %w{serotonin oxytocin dopamine GABA}; end

  def produce; choose Verb, %w{walk talk spend predict}; end
  def consume; choose Verb, %w{eat listen earn look}; end

  def consume_helper; choose Word, %w{NIL to NIL at}; end
  def consume_with
    consume_helper ? Phrase.new([consume, consume_helper]) : consume
  end
  def provide; choose Verb, %w{cook give reward show}; end
  def provide_helper; choose Word, %w{for to to to}; end
  def strengtheners; choose Noun, %w{protein criticism investment\ income patterns}; end
  def energizers; choose Noun, %w{carbs praise wages exceptions}; end
  def buffers; choose Noun, %w{fat self-deprecation reinvestments mnemonics}; end
  def nasty; choose Adjective, %w{tough whiny risky unbalanced}; end
  def nice; choose Adjective, %w{tender constructive safe symmetric}; end

  def strengths; choose Noun, %w{muscles morality assets rules}; end
  def kinetics; choose Noun, %w{glycogen opinions cash facts}; end
  def potentials; choose Noun, %w{fat self-esteem savings knowledge}; end

  def empty; choose Adjective, %w{hungry guilty poor unsure}; end
  def dying; choose Adjective, %w{starving suicidal destitute wrong}; end


  def adjective; choose Adjective, %w{physical social financial mental}; end
  def name; Phrase.new [adjective.titleize, parenthesize]; end
  def adverb; adjective.ly; end

  def produce_long
    ["go new places and do more things",
     "win new friends and influence more people",
     "pursue new pleasures and obtain more comforts",
     "solve new problems and change more futures"][index].to_phrase
  end
  def thing; choose Noun, %w{where one thing thing}; end
  def things; choose Noun, %w{places people pleasures futures}; end
  def produce_short; choose Verb, %w{go influence pursue change}; end

end
