class Answer

  def initialize(string)
    @path = string
    @question,@letters = string.split("_")
    @letters = "" unless @letters
  end
  attr_reader :path, :question, :letters

  def number; @question.last.to_i ; end

  def subtypes; @letters.scan(/..../).collect{|l| Subtype.find(l)}; end
  def chosen?(subtype); subtypes.include?(subtype); end

  def attitudes; subtypes.map(&:attitude); end
  def chosen_attitude?(subtype); attitudes.include?(subtype.attitude); end

  def realms; subtypes.map(&:realm); end
  def chosen_realm?(subtype); realms.include?(subtype.realm); end

  def constrained?(subtype); chosen_attitude?(subtype) || chosen_realm?(subtype); end

  def css(subtype)
    if chosen?(subtype)
      "chosen"
    elsif constrained?(subtype)
      "constrained"
    else
      "free"
    end
  end

  def subtypes_to_keep(string)
    new_subtype = Subtype.find(string)
    subtypes.select{|s| s.attitude != new_subtype.attitude && s.realm != new_subtype.realm}
  end

  def next(string)
    if css(Subtype.find(string)) == "constrained"
      number = subtypes_to_keep(string).size + 2
      "Q#{number}_" + subtypes_to_keep(string).map(&:path).join + string
    elsif css(Subtype.find(string)) == "chosen"
      question + "_" + letters
    else
      question.next + "_" + letters + string
    end
  end

  def quad_path; subtypes[0,4].sort_by{|s| s.attitude.index}.map(&:realm).map(&:path).join; end

end
