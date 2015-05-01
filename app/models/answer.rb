class Answer

  def initialize(string)
    @question,@letters = string.split("_")
    @letters = "" unless @letters
  end
  attr_reader :question

  def number; @question.last.to_i ; end
  def behavior_letters; @letters[0,8]; end
  def behaviors; behavior_letters.scan(/../).collect{|ra| Behavior.find(ra)}; end

  def attitudes; behaviors.map(&:attitude); end
  def attitude
    return Attitude.all.first if attitudes.empty?
    attitude = attitudes.last.next
    while attitudes.include?(attitudes)
      attitude = attitude.next
    end
    attitude
  end

  def realms; behaviors.map(&:realm); end
  def chosen?(behavior); realms.include?(behavior.realm); end
  def css(behavior); chosen?(behavior) ? "chosen" : "free"; end
  def reset_path; "Q5_" + behavior_letters; end

  def behavior_problem_letters; @letters[8,14]; end
  def behavior_problems; behavior_problem_letters.scan(/.../).collect{|rap| BehaviorProblem.find(rap)}; end
  def behavior
    behaviors.each do |behavior|
      return behavior unless behavior_problems.map(&:behavior).include?(behavior)
    end
  end

  def next(letters);
    if number < 5
      new_behavior =  Behavior.find(letters)
      old_behaviors = behaviors.reject{|b| b.attitude == new_behavior.attitude}
      "Q" + old_behaviors.size.to_s.next.next + "_" + old_behaviors.map(&:letters).join + letters
    else
      @question.next + "_" + @letters + letters
    end
  end

  def attitude_problems; behavior_problems.sort_by{|bp| bp.realm.index}.map(&:attitude_problem); end
  def type_path; attitude_problems.map(&:letters).join ; end
end
