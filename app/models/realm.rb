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
  def neuro; choose Noun, %w{serotonin oxytocin dopamine epinephrine}; end

  def act; choose Verb, %w{walk talk  shop think}; end
  def consume; choose Verb, %w{eat listen earn look}; end
  def consume_helper; choose Word, %w{NIL to NIL at}; end

  def resources; choose Noun, %w{food stories tools information}; end
  def nasty; choose Adjective, %w{tough whiny earned unbalanced}; end
  def nice; choose Adjective, %w{tender constructive unearned symmetric}; end
  def strengtheners; choose Noun, %w{protein criticism assets patterns}; end
  def energizers; choose Noun, %w{carbs praise wages specifics}; end
  def buffers; choose Noun, %w{fat humor deductions categories}; end

  # process the resources
  def process; choose Verb, %w{cook sing package show}; end
  # provide the resources to someone
  def provide; choose Verb, %w{cook perform reward demonstrate}; end
  def to; choose Word, %w{for to to to}; end
  # someone can get the resources
  def get; choose Verb, %w{digest understand use believe}; end
  def get_resources; Phrase.new [get, resources]; end


  def strengths; choose Noun, %w{muscles values credit logic}; end
  def energy; choose Noun, %w{glycogen self-esteem cash facts}; end
  def potential_energy; choose Noun, %w{fat egotism savings memories}; end

  def worn_out; choose Adjective, %w{sore boring indebted confused}; end
  def empty; choose Adjective, %w{hungry unloved poor unsure}; end
  def even_emptier; choose Adjective, %w{starving suicidal homeless stupid }; end
  def death; choose Noun, %w{starvation suicide exposure  stupidity}; end

  def generic; choose Adjective, %w{physical verbal financial mental}; end
  def adverb; generic.ly; end
  def name; Phrase.new [generic.titleize, parenthesize]; end

  def produce_verb; choose Verb, %w{go win pursue solve}; end
  def produce_adjective; choose Adjective, %w{long allied memorable complex}; end
  def produce_nouns; choose Noun, %w{distances friends experiences problems}; end
  def produce(inject=produce_adjective)
    if generic?
      Phrase.new ["energetic", "action"]
    else
      Phrase.new [produce_verb, inject, produce_nouns]
    end
  end

  def achieve; choose Verb, %w{lift influence own predict}; end
  def difficult; choose Adjective, %w{heavy hostile safe improbable}; end
  def effects; choose Noun, %w{weights enemies places outcomes}; end
  def effect(inject=difficult)
    if generic?
      Phrase.new ["strong", "action"]
    else
      Phrase.new [achieve, inject, effects]
    end
  end

  def produce_effects; Phrase.new [produce("new"), "and/or", effect("more")]; end
end
