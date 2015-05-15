class Answer

  def initialize(string)
    @question,@letters = string.split("_")
    @letters = "" unless @letters
  end
  attr_reader :question

  def number; @question.last.to_i ; end

  def state_letters; @letters[0,8]; end
  def states; state_letters.scan(/../).collect{|ar| State.find(ar)}; end

  def attitudes; states.map(&:attitude); end
  def unchosen; Attitude.all - attitudes; end
  def random_attitude; unchosen.sample; end

  def next(letters);
    new_state = State.find(letters)
    old_states = states.reject{|s| s.realm == new_state.realm}
    "Q" + old_states.size.to_s.next.next + "_" + old_states.map(&:letters).join + letters
  end

  def realms; states.map(&:realm); end
  def realm_chosen?(state); realms.include?(state.realm) ? "chosen" : "free"; end

  def realm; (Realm.all - realms).first; end
  def fixme(letters);
    new_state = State.find(letters)
    old_states = states.reject{|s| s.attitude == new_state.attitude}
    "Q" + old_states.size.to_s.next.next + "_" + old_states.map(&:letters).join + letters
  end
  def attitude_replace?(state); attitudes.include?(state.attitude) ? "free" : "chosen"; end

  def sorted_states; states.sort_by{|s| s.attitude.index}; end
  def path; sorted_states.map(&:realm).map(&:letter).join; end

end
