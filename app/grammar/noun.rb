class Noun < Word

  def time; suffix("-time"); end

  def any; prefix("any"); end
  def no; prefix("no"); end
  def some; prefix("some"); end
  def every; prefix("every"); end
  def the; Phrase.new ["the", self]; end


  def if_uncountable(yes, no); (is_uncountable? ? yes : no).to_word; end
  def if_uncountable_suffix(yes, no); Phrase.new [self, if_uncountable(yes, no)]; end

  def they; if_uncountable("it", "they"); end
  def them; if_uncountable("it", "them"); end
  def their; if_uncountable("its", "their"); end
  def were; if_uncountable("was", "were"); end
  def many; if_uncountable("much", "many"); end
  def many_phrase(injection=nil); Phrase.new [many, injection, self]; end
  def few; if_uncountable("little", "few"); end
  def few_phrase; Phrase.new [few, self]; end
  def fewer; if_uncountable("less", "fewer"); end
  def fewer_phrase(qualifier=nil); Phrase.new [fewer, qualifier, self]; end
  def are; if_uncountable("is", "are"); end
  def are_phrase; Phrase.new [self, are]; end
  def have; if_uncountable("has", "have"); end
  def have_phrase; Phrase.new [self, have]; end
  def make; if_uncountable("makes", "make"); end
  def make_phrase; Phrase.new [self, make]; end
  def do; if_uncountable("does", "do"); end
  def do_make_phrase; Phrase.new [self, self.do, "make"]; end
  def dont; if_uncountable("doesn’t", "don’t"); end
  def dont_phrase; Phrase.new [self, dont]; end
  def dont_have_phrase; Phrase.new [self, dont, "have"]; end
  def they_do; Phrase.new [they, self.do]; end
  def they_dont; Phrase.new [they, dont]; end
  def they_are; Phrase.new [they, are]; end
  def are_contracted; if_uncountable("’s", "’re"); end
  def they_are_contracted; they.suffix(are_contracted); end
  def arent; if_uncountable("isn’t", "aren’t"); end
  def they_arent; Phrase.new [they, arent]; end
  def havent; if_uncountable("hasn’t", "haven’t"); end
  def they_havent; Phrase.new [they, havent]; end

  private

  ## if the word needs to be either singular or plural
  ## make the method name plural, and add the singulars here
  UNCOUNTABLE = %w{vocabulary food fat stuff music harmony information weight
   knowledge net-worth job story confidence task money credit optimism wealth
   demonstration meal show family hope love protein cash heart body
   working\ memory lexical-meaning expressive-meaning music faith
   emotional-expression tone\ of\ voice empathy glycogen like learning recall
   trust intonation head stomach horror color romance library fire defence}
  def is_uncountable?; UNCOUNTABLE.include?(@string); end

end
