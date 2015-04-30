class Answer

  def initialize(string)
    @question,@letters = string.split("_")
    @letters = "" unless @letters
  end
  attr_reader :question

  def number; @question.last.to_i ; end

  def behaviors; @letters[0,8].scan(/../).collect{|ar| Behavior.find(ar)}; end
  def realms; behaviors.map(&:realm); end
  def realm
    return Realm.all.first if realms.empty?
    realm = realms.last.next
    while realms.include?(realm)
      realm = realm.next
    end
    realm
  end

  def subtypes; @letters[8..-1].scan(/.../).collect{|par| Subtype.find(par)}; end
  def priorities; subtypes.map(&:priority); end
  def priority
    return Priority.all.first if priorities.empty?
    priority = priorities.last.next
    while priorities.include?(priority)
      priority = priority.next
    end
    priority
  end

  def choices; behaviors.sort_by{|b| b.attitude.index}.collect{|b| b + priority}; end

  def css(thing); free?(thing) ? "free" : "chosen"; end
  def free?(thing)
    if thing.is_a?(Behavior)
      ! thing.wing?(behaviors)
    elsif thing.is_a?(Subtype)
      ! thing.wing?(subtypes)
    end
  end

  def behavior_letters; behaviors.map(&:letters).join; end
  def reset_path; "Q5_" + behavior_letters; end

  def next(letters);
    if number < 5
      choice =  Behavior.find(letters)
      old_behaviors = behaviors.reject{|b| b.wing?([choice])}
      "Q" + old_behaviors.size.to_s.next.next + "_" + old_behaviors.map(&:letters).join + letters
    else
      choice =  Subtype.find(letters)
      old_subtypes = subtypes.reject{|s| s.wing?([choice])}
      "Q" + (old_subtypes.size + 4).to_s.next.next + "_" + behavior_letters +  old_subtypes.map(&:letters).join + letters
    end
  end

  def type_path; subtypes.sort_by{|s| s.priority.index}.map(&:behavior).map(&:letters).join; end
end
