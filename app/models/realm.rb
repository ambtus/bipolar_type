class Realm < Concept

  SYMBOLS = %w{F S T N}

  ########
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  PATHS = SYMBOLS.map(&:downcase)
  PATHS.each do |path|
    define_singleton_method(path) {ALL[PATHS.index(path)]}
  end
  ########

  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  def +(attitude); subtypes.find{|s| s.attitude == attitude}; end

  def adjective; %w{social physical financial mental}[index]; end
  def name; adjective.capitalize; end

  def verb; %w{tell go pay\ for organize}[index]; end
  def noun; %w{person place thing idea}[index]; end
  def nouns; noun.pluralize; end

  def work(which="important"); [verb, which, nouns].to_phrase; end
  def whole; %w{family destination tools theories}[index]; end
  def play; %w{sing dance splurge imagine}[index]; end

  def thing; %w{body where thing thing}[index]; end # some#{thing}, no#{thing}, etc.
  def it; index == 0 ? "them" : "it"; end

  def use; %w{express burn spend synthesize}[index]; end
  def energy; %w{love calories money facts}[index]; end
  def reserves; %w{values fat savings memories}[index]; end
  def on; %w{to in on into}[index]; end

  def intake; %w{listen eat earn watch}[index]; end
  def output; %w{talk move buy think}[index]; end

  def take; %w{hear taste collect see}[index]; end
  def source; %w{opinion food reward result}[index]; end
  def sources; source.pluralize; end

  def refresh; [take, "good", sources].to_phrase; end

  def overwhelmed; %w{ashamed disgusted angry afraid}[index]; end

  def sleep; "convert #{energy} to #{reserves}"; end
  def dream(who="I"); "contemplate the #{nouns} #{who} want to #{verb} before #{who} start #{output.ing}"; end
end
