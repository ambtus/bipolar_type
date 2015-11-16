class Noun < Word

  def if_uncountable(yes, no=self); (is_uncountable? ? yes : no).to_word; end

  def they; if_uncountable("it", "they"); end
  def them; if_uncountable("it", "them"); end
  def their; if_uncountable("its", "their"); end
  def were; if_uncountable("was", "were"); end
  def many; if_uncountable("much", "many"); end
  def many_phrase; Phrase.new [many, self]; end
  def few; if_uncountable("little", "few"); end
  def few_phrase; Phrase.new [few, self]; end
  def fewer; if_uncountable("less", "fewer"); end
  def fewer_phrase; Phrase.new [fewer, self]; end
  def are; if_uncountable("is", "are"); end
  def are_phrase; Phrase.new [self, are]; end
  def have; if_uncountable("has", "have"); end
  def have_phrase; Phrase.new [self, have]; end
  def do; if_uncountable("does", "do"); end
  def dont; if_uncountable("doesn’t", "don’t"); end
  def dont_phrase; Phrase.new [self, dont]; end
  def they_do; Phrase.new [they, self.do]; end
  def they_are; Phrase.new [they, are]; end
  def are_contracted; if_uncountable("’s", "’re"); end
  def they_are_contracted; they.suffix(are_contracted); end
  def arent; if_uncountable("isn’t", "aren’t"); end
  def they_arent; Phrase.new [they, arent]; end

  private

  ## if the word needs to be either singular or plural
  ## make the method name plural, and add the singulars here
  UNCOUNTABLE = %w{vocabulary food fat stuff music harmony information weight knowledge net-worth job story confidence task money credit optimism wealth demonstration meal show family hope love savings protein cash heart body}
  def is_uncountable?; UNCOUNTABLE.include?(@string); end

end
