class Attitude < Indexable

  def domain; choose Noun, %w{ obesity weakness bulkiness anorexia }; end
  ########
  LETTERS = %w{ o w b a }
  ALL = LETTERS.collect{|letter| self.new letter}
  all.each { |a| define_singleton_method(a.path) {all[LETTERS.index a.string]} }
  ########

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end
  def generic_subtype; Subtype.new [Realm.generic, self]; end

  def morning_feeling; choose Adjective, %w{ ready empty empty ready  }; end
  def morning_behavior; choose Verb, %w{ produce consume consume produce  }; end
  def morning_class; "normal"; end

  def afternoon_feeling; choose Adjective, %w{ worn\ out full full worn\ out  }; end
  def afternoon_behavior_verb; choose Verb, %w{ consume consume produce produce }; end
  def afternoon_behavior_suffix; choose Word, %w{ NIL energizers NIL strongly }; end
  def afternoon_class; %w{normal warning normal warning}[index]; end

  def evening_feeling_prefix; choose Word, %w{ NIL very NIL very }; end
  def evening_feeling_adjective; choose Adjective, %w{ full full worn\ out worn\ out }; end
  def evening_behavior_verb; choose Verb, %w{ consume produce produce consume }; end
  def evening_behavior_suffix; choose Word, %w{ energizers energetically strongly strengtheners }; end
  def evening_class; %w{ warning normal warning normal}[index]; end

  def night_feeling_prefix; choose Word, %w{ very NIL very NIL }; end
  def night_feeling_adjective; choose Adjective, %w{ full full worn\ out worn\ out }; end
  def night_verb; choose Verb, %w{ gain lose gain lose }; end
  def night_noun; choose Noun, %w{ potential\ energy strengths strengths potential\ energy }; end
  def night_class; "normal"; end

  def name; domain.titleize; end
  def afternoon_behavior; Phrase.optional afternoon_behavior_verb, afternoon_behavior_suffix; end
  def evening_feeling; Phrase.optional evening_feeling_prefix, evening_feeling_adjective; end
  def evening_behavior; Phrase.optional evening_behavior_verb, evening_behavior_suffix; end
  def night_feeling; Phrase.optional night_feeling_prefix, night_feeling_adjective; end
  def night_behavior; Phrase.new [night_verb, night_noun]; end

end
