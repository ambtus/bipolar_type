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

  def chosen; @answer.scan(/.../).collect{|subtype| Subtype.find(subtype)}; end
  def constrained; (chosen.map(&:same_energy) + chosen.map(&:same_attitude)).flatten.uniq; end
  def class(subtype)
    if chosen.include? subtype
      "chosen" 
    elsif constrained.include? subtype
      "warning"
    else
      "free"
    end
  end

  def realms; Realm.all - chosen; end

  def next(subtype)
    subtypes = chosen.reject{|s| subtype.same_energy.include?(s) || subtype.same_attitude.include?(s)}
    "Q" + subtypes.size.next.next.to_s + "_" + subtypes.join + subtype
  end

  def quad_path; chosen.sort.join; end

end
