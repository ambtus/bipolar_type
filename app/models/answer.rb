class Answer

  def initialize(string)
    @question,@letters = string.split("_")
    @letters = "" unless @letters
  end
  attr_reader :question, :letters

  def number; @question.last.to_i ; end

  def behaviors; @letters.scan(/../).collect{|l| Behavior.find(l)}; end

  def chosen?(behavior); behaviors.include?(behavior); end

  def attitudes; behaviors.map(&:attitude); end
  def chosen_attitudes; attitudes.dupes; end
  def hanging_attitude; (attitudes - chosen_attitudes).first; end
  def attitude_choices
    return [] unless hanging_attitude
    hanging_attitude.behaviors.reject{|b| chosen_realms.include?(b.realm)}
  end

  def realms; behaviors.map(&:realm); end
  def chosen_realms; realms.dupes; end
  def hanging_realm; (realms - chosen_realms).first; end
  def realm_choices
    return [] unless hanging_realm
    hanging_realm.behaviors.reject{|b| chosen_attitudes.include?(b.attitude)}
  end

  def hanging_behavior; return unless hanging_realm && hanging_attitude; hanging_realm + hanging_attitude; end

  def choices
    return Behavior.all if number == 1
    attitude_choices + realm_choices - [hanging_behavior]
  end

  def free?(behavior); choices.include?(behavior); end

  def css(behavior)
    if chosen?(behavior)
      "chosen"
    elsif free?(behavior)
      "free"
    else
      "restart"
    end
  end

  def next(string)
    if css(Behavior.find(string)) == "chosen"
      question + "_" + letters
    elsif css(Behavior.find(string)) == "restart"
      "Q2_" + string
    else
      question.next + "_" + letters + string
    end
  end

  def last_realm; Realm.all - realms; end
  def all_realms; realms.uniq + last_realm; end
  def last_attitude; Attitude.all - attitudes; end
  def all_attitudes; attitudes.uniq + last_attitude; end

  def type_path; all_realms.map(&:path).join + all_attitudes.map(&:path).join; end

end
