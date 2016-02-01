class Attitude < Indexable

  ########
  IDENTIFIERS = %w{ obesity weakness bulkiness anorexia }
  def self.paths; IDENTIFIERS; end
  ALL = IDENTIFIERS.collect{|letter| self.new letter}
  all.each { |a| define_singleton_method(a.path) {all[IDENTIFIERS.index a.string]} }
  ########

  def consumer?; index < 2; end
  def today?; index.odd?; end

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end
  def generic_subtype; Subtype.new [Realm.generic, self]; end

  def morning_feeling; choose Adjective, %w{ ready empty empty ready  }; end
  def morning_behavior_verb; choose Verb, %w{ produce consume consume produce  }; end
  def morning_behavior_suffix; choose Word, %w{ normally normally normally normally }; end
  def morning_class; "normal"; end

  def afternoon_feeling; choose Adjective, %w{ worn\ out full full worn\ out  }; end
  def afternoon_behavior_verb; choose Verb, %w{ consume consume produce produce }; end
  def afternoon_behavior_suffix; choose Word, %w{ normally energizers normally strongly }; end
  def afternoon_class; %w{normal warning normal warning}[index]; end

  def evening_feeling; choose Adjective, %w{ full full worn\ out worn\ out }; end
  def evening_behavior_verb; choose Verb, %w{ consume produce produce consume }; end
  def evening_behavior_suffix; choose Word, %w{ energizers energetically strongly strengtheners }; end
  def evening_class; %w{ warning normal warning normal}[index]; end

  def identifier; choose Adjective, IDENTIFIERS; end
  def name; identifier.titleize; end
  def morning_behavior; Phrase.optional morning_behavior_verb, morning_behavior_suffix; end
  def afternoon_behavior; Phrase.optional afternoon_behavior_verb, afternoon_behavior_suffix; end
  def evening_behavior; Phrase.optional evening_behavior_verb, evening_behavior_suffix; end

end
