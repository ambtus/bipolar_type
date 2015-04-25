class Answer

  def initialize(string)
    @question,@letters = string.split("_")
    @letters = "" unless @letters
  end
  attr_reader :question

  def number; @question.last.to_i ; end

  def subtypes; @letters.scan(/../).collect{|x| Subtype.find(x)}; end

  def chosen?(subtype); subtypes.include?(subtype); end
  def free?(subtype); ! subtype.wing?(subtypes); end
  def love?(subtype); subtypes.first == subtype; end
  def like?(subtype); subtypes.second == subtype; end
  def okay?(subtype); subtypes.third == subtype; end

  def next(letters);
    subtype =  Subtype.find(letters)
    if free?(subtype)
      @question.next + "_" + @letters + letters
    else
      replaced = subtypes.select do |current|
        subtype.wing?([current])
      end
      new_subtypes = subtypes - replaced
      "Q" + new_subtypes.size.to_s.next.next + "_" + new_subtypes.map(&:letters).join + letters
    end
  end

  def type_path(last); (@letters + last); end
end
