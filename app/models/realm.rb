class Realm < Concept

  SYMBOLS = %w{F S T N}

  ########
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  PATHS = SYMBOLS.map(&:downcase)
  PATHS.each do |path|
    define_singleton_method(path) {ALL[PATHS.index(path)]}
  end
  ########

  def path; PATHS[index]; end

  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  def +(attitude); subtypes.find{|s| s.attitude == attitude}; end

  def adjective; %w{affective physical financial mental}[index]; end
  def name; adjective.capitalize; end

  def verb; %w{influence go\ to improve organize}[index]; end
  def noun; %w{person place thing idea}[index]; end
  def nouns; noun.pluralize; end
  def mine; %w{family bedroom investments theories}[index]; end
  def work; %w{write garden invest think}[index]; end
  def play; %w{talk dance splurge guess}[index]; end
  def refresh; %w{listen eat compete watch}[index]; end
  def dream(whose="my"); [verb, whose, mine].to_phrase; end

  def work_others; %w{write hunt/gather/cook buy/build/upgrade/repair prove}[index]; end

  def thing; %w{body where thing thing}[index]; end # some#{thing}, no#{thing}, etc.
  def it; index == 0 ? "them" : "it"; end

  def use; %w{express burn spend synthesize}[index]; end
  def energy; %w{love calories money facts}[index]; end
  def reserves; %w{values fat savings knowledge}[index]; end
  def on; %w{to in on into}[index]; end

  def take; %w{hear taste collect watch}[index]; end
  def source; %w{response food reward result}[index]; end
  def sources; source.pluralize; end

  def refresh_long; [take, "the", sources].to_phrase; end

  def overwhelmed; %w{ashamed disgusted angry afraid}[index]; end

  def sleep; "preserve #{energy} as #{reserves}"; end
  def dream_long(who="I"); "consider the #{nouns} #{who} want to #{verb} before #{who} start #{work.ing}"; end
end
