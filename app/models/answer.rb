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
  def weak?(subtype); subtypes.third == subtype; end

  def basic; subtypes.first.attitude.basic; end

  def basic?(subtype); subtype.attitude.basic == basic; end

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

  def type_path(last); basic + (@letters + last).scan(/../).sort_by{|x| x.first}.join; end
end
