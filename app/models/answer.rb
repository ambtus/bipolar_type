class Answer

  def initialize(string)
    @question,@letters = string.split("_")
    @letters = "" unless @letters
  end
  attr_reader :question

  def number; @question.last.to_i ; end

  def subtypes; @letters.scan(/.../).collect{|x| Subtype.find(x)}; end
  def priorities; subtypes.map(&:priority); end

  def chosen?(subtype); subtype.wing?([subtype]); end
  def free?(subtype); ! subtype.wing?(subtypes); end

  def priority;
    return Priority.all.first if priorities.empty?
    priority = priorities.last.next
    while priorities.include?(priority)
      priority = priority.next
    end
    priority
  end

  def descriptions; subtypes.sort_by{|s| s.priority.index}.map(&:short); end

  def css(subtype); free?(subtype) ? "free" : "chosen"; end

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

  def type_path(last); (@letters + last).scan(/.../).sort.collect{|s| s[1,2]}.join; end
end
