class Answer

  def self.first_path; "Q1"; end
  def self.first; Answer.new(first_path); end

  def initialize(string)
    @question,@answer = string.split("_")
    @answer = "" unless @answer
  end
  attr_reader :question, :answer

  def number; @question.last.to_i ; end
  def finished?; number == 5; end

  def chosen; @answer.scan(/.../).collect{|subtype| Subtype.send(subtype)}; end
  def constrained
    (chosen.map(&:same_realm) + chosen.map(&:same_attitude)).flatten.uniq
  end
  def partially_constrained; chosen.map(&:same_realm).flatten; end
  def class(subtype)
    if chosen.include? subtype
      "chosen"
    elsif constrained.include? subtype
      "warning"
    else
      "free"
    end
  end

  def fully_constrained_subtypes(subtype)
    chosen.reject do |s|
      subtype.same_realm.include?(s) || subtype.same_attitude.include?(s)
    end
  end
  def partially_constrained_subtypes(subtype); chosen.reject{|s| subtype.same_realm.include?(s)}; end
  def subtypes(subtype); fully_constrained_subtypes(subtype); end
  def next(subtype)
    "Q" + subtypes(subtype).size.next.next.to_s + "_" + subtypes(subtype).map(&:path).join + subtype.path
  end

  def quad_path; chosen.sort.map(&:path).join; end

end
