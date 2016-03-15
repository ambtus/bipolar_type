class Noun < Word

  def pluralize; Noun.new(string.pluralize); end

  def time; suffix("-time"); end

  def any; prefix("any"); end
  def no; prefix("no"); end
  def some; prefix("some"); end
  def every; prefix("every"); end
  def the; Phrase.new ["the", self]; end

  def uncountable?; UNCOUNTABLE.include?(@string); end
  def uncountable(yes, no); (uncountable? ? yes : no).to_word; end

  def they; uncountable("it", "they"); end
  def them; uncountable("it", "them"); end
  def their; uncountable("its", "their"); end
  def were; uncountable("was", "were"); end
  def many; uncountable("much", "many"); end
  def many_phrase(injection=nil); Phrase.new [many, injection, self]; end
  def more; "more"; end
  def more_phrase; Phrase.new ["more", self]; end
  def few; uncountable("little", "few"); end
  def few_phrase; Phrase.new [few, self]; end
  def fewer; uncountable("less", "fewer"); end
  def fewer_phrase(qualifier=nil); Phrase.new [fewer, qualifier, self]; end
  def fewest; uncountable("least", "fewest"); end
  def fewest_phrase(qualifier=nil); Phrase.new [fewest, qualifier, self]; end
  def are; uncountable("is", "are"); end
  def are_phrase; Phrase.new [self, are]; end
  def have; uncountable("has", "have"); end
  def have_phrase; Phrase.new [self, have]; end
  def make; uncountable("makes", "make"); end
  def make_phrase; Phrase.new [self, make]; end
  def do; uncountable("does", "do"); end
  def do_make_phrase; Phrase.new [self, self.do, "make"]; end
  def dont; uncountable("doesn’t", "don’t"); end
  def dont_phrase; Phrase.new [self, dont]; end
  def dont_have_phrase; Phrase.new [self, dont, "have"]; end
  def they_do; Phrase.new [they, self.do]; end
  def they_dont; Phrase.new [they, dont]; end
  def they_are; Phrase.new [they, are]; end
  def they_were; Phrase.new [they, were]; end
  def are_contracted; uncountable("’s", "’re"); end
  def they_are_contracted; they.suffix(are_contracted); end
  def arent; uncountable("isn’t", "aren’t"); end
  def they_arent; Phrase.new [they, arent]; end
  def havent; uncountable("hasn’t", "haven’t"); end
  def they_havent; Phrase.new [they, havent]; end
  def those; uncountable("that", "those"); end
  def those_phrase; Phrase.new [those, self]; end
  def these; uncountable("this", "these"); end

  private

  ## if the word needs to be either singular or plural
  ## make the method name plural, and add the singulars here
  UNCOUNTABLE = %w{vocabulary food fat stuff music harmony information weight
   knowledge net-worth job story confidence task money credit optimism wealth
   demonstration meal show family hope love protein cash heart body
   working\ memory lexical-meaning expressive-meaning music faith
   emotional-expression tone\ of\ voice empathy glycogen like learning recall
   trust intonation head stomach horror color romance library fire defense
   offense tragedy shelter self-esteem praise criticism investment\ income
   self-deprecation potential\ energy egotism kinetic\ energy trivia safety
   comfort skin soul mind property credit\ rating dessert energy 
   spending\ money salary regular\ income bonus\ income truth
   symmetry dissonance pain shame logic language nose}

end
