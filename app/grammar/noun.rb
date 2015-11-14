class Noun < Word

  def if_uncountable(yes, no=self); (is_uncountable? ? yes : no).to_word; end

  def they; if_uncountable("it", "they"); end
  def them; if_uncountable("it", "them"); end
  def their; if_uncountable("its", "their"); end
  def were; if_uncountable("was", "were"); end
  def many; if_uncountable("much", "many"); end
  def many_phrase; [many, self].to_phrase; end
  def few; if_uncountable("little", "few"); end
  def few_phrase; [few, self].to_phrase; end
  def fewer; if_uncountable("less", "fewer"); end
  def fewer_phrase; [fewer, self].to_phrase; end
  def are; if_uncountable("is", "are"); end
  def are_phrase; [are, self].to_phrase; end
  def dont; if_uncountable("doesn’t", "don’t"); end
  def dont_phrase; [self, dont].to_phrase; end
  def they_are; [they, are].to_phrase; end
  def are_contracted; if_uncountable("’s", "’re"); end
  def they_are_contracted; they.suffix(are_contracted); end
  def are_many(inject=""); [are.suffix(inject), many].to_phrase; end
  def are_many_phrase(inject=""); [are_many(inject),self].to_phrase; end

  private

  ## if the word needs to be either singular or plural
  ## make the method name plural, and add the singulars here
  UNCOUNTABLE = %w{savings vocabulary food fat stuff}
  def is_uncountable?; UNCOUNTABLE.include?(@string); end

end
