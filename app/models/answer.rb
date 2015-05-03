class Answer

  def initialize(string)
    @question,@letters = string.split("_")
    @letters = "" unless @letters
  end
  attr_reader :question

  def number; @question.last.to_i ; end
  def state_letters; @letters[0,12]; end
  def states; state_letters.scan(/.../).collect{|ar| State.find(ar)}; end

  def attitudes; states.map(&:attitude); end
  def attitude
    return Attitude.all.first if attitudes.empty?
    attitude = attitudes.last.lower
    while attitudes.include?(attitude); attitude = attitude.lower; end
    return attitude
  end

  def realms; states.map(&:realm); end
  def css(state); realms.include?(state.realm) ? "chosen" : "free"; end

  def next(letters);
    new_state = State.find(letters)
    old_states = states.reject{|s| s.realm == new_state.realm}
    "Q" + old_states.size.to_s.next.next + "_" + old_states.map(&:letters).join + letters
  end

  def sorted_states; states.sort_by{|s| s.attitude.index}; end
  def manic; sorted_states.first; end
  def depressed; sorted_states.last; end
  def sorted_letters; sorted_states.map(&:realm).map(&:letter).join; end
  def introvert; Type.new("i" + sorted_letters); end
  def extrovert; Type.new("e" + sorted_letters); end

end
