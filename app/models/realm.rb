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

  def domain; choose Adjective, %w{gustatory auditory tactile visual}; end
  #def name; Phrase.new [domain.titleize, parenthesize]; end
  #def name; domain.titleize; end
  def sensory; choose Noun, %w{taste/smell hearing touch/pain sight}; end
  def sense; choose Verb, %w{smell hear hold see}; end
  def appear; choose Verb, %w{taste sound feel look}; end
  def neuro; choose Noun, %w{serotonin oxytocin dopamine GABA}; end

  def perform; choose Verb, %w{walk talk spend predict}; end
  def consume; choose Verb, %w{eat listen earn look}; end

  def consume_helper; choose Word, %w{NIL to NIL at}; end
  def provide; choose Verb, %w{cook tell reward show}; end
  def provide_helper; choose Word, %w{for to to to}; end
  def process; choose Verb, %w{cook sing hand show}; end
  def get; choose Verb, %w{digest understand accept believe}; end

  def resources; choose Noun, %w{foods stories tools information}; end
  def strong_resources; choose Noun, %w{protein criticism investment\ income patterns}; end
  def energetic_resources; choose Noun, %w{carbs praise wages colors}; end
  def buffers; choose Noun, %w{fat self-deprecation reinvestments organization}; end
  def nasty; choose Adjective, %w{tough whiny risky unbalanced}; end
  def nice; choose Adjective, %w{tender constructive safe symmetric}; end

  def strengths; choose Noun, %w{muscles vocabulary assets rules}; end
  def kinetic_energy; choose Noun, %w{glycogen self-esteem cash facts}; end
  def potential_energy; choose Noun, %w{fat egotism savings trivia}; end

  def worn_out; choose Adjective, %w{sore misunderstood indebted stupid}; end
  def weakness; choose Noun, %w{starvation suicide destitution stupidity}; end
  def empty; choose Adjective, %w{hungry guilty poor unsure}; end
  def even_emptier; choose Adjective, %w{starving suicidal destitute wrong}; end


  def generic; choose Adjective, %w{physical spiritual material mental}; end
  def name; Phrase.new [generic.titleize, parenthesize]; end

  def produce_verb; choose Verb, %w{go win pursue solve}; end
  def produce_nouns; choose Noun, %w{places friends pleasures problems}; end
  def produce(inject="")
    if generic?
      Phrase.new ["produce", inject, "things"]
    else
      Phrase.new [produce_verb, inject, produce_nouns]
    end
  end

  def effect_verb; choose Verb, %w{do influence obtain change}; end
  def effect_nouns; choose Noun, %w{things people safety futures}; end
  def effect(inject="")
    if generic? 
      Phrase.new ["effect", inject, "things"]
    else
      Phrase.new [effect_verb, inject, effect_nouns]
    end
  end

  def produce_effects; Phrase.new [produce("new"), "and/or", effect("more")]; end
end
