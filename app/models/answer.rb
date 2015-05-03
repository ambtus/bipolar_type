class Answer

  def initialize(string)
    @question,@letters = string.split("_")
    @letters = "" unless @letters
  end
  attr_reader :question

  def number; @question.last.to_i ; end
  def trait_letters; @letters[0,8]; end
  def traits; trait_letters.scan(/../).collect{|ra| Trait.find(ra)}; end

  def attitudes; traits.map(&:attitude); end
  def attitude
    return Attitude.all.first if attitudes.empty?
    attitude = attitudes.last.next
    while attitudes.include?(attitude); attitude = attitude.next; end
    return attitude
  end

  def realms; traits.map(&:realm); end
  def css(trait); realms.include?(trait.realm) ? "chosen" : "free"; end

  def next(letters);
    new_trait =  Trait.find(letters)
    old_traits = traits.reject{|t| t.realm == new_trait.realm}
    "Q" + old_traits.size.to_s.next.next + "_" + old_traits.map(&:letters).join + letters
  end

  def sorted_traits; traits.sort_by{|t| t.realm.index}; end
  def sorted_letters; sorted_traits.map(&:letters).join; end
  def clockwise; Type.new(sorted_letters + "n"); end
  def counterclockwise; Type.new(sorted_letters + "p"); end

end
