class Answer

  def self.first_path; "Q1"; end
  def self.first; Answer.new(first_path); end

  def initialize(string)
    @question,subtypes = string.split(":")
    @subtype_paths = (subtypes || "").split("-")
  end
  attr_reader :question, :subtype_paths

  def number; @question.last.to_i ; end
  def finished?; number == 5; end

  def chosen; subtype_paths.collect{|subtype| Subtype.send(subtype)}; end
  def constrained;  (chosen.map(&:same_realm) + chosen.map(&:same_attitude)).flatten.uniq; end

  def class(subtype)
    if chosen.include? subtype
      "chosen"
    elsif constrained.include? subtype
      "warning"
    else
      "free"
    end
  end

  def remaining(subtype)
    chosen.reject {|s| subtype.same_realm.include?(s) || subtype.same_attitude.include?(s) }
  end
  def all(subtype); remaining(subtype) + [subtype]; end
  def next(subtype)
    "Q" + remaining(subtype).size.next.next.to_s + ":" + 
    all(subtype).map(&:path).join("-")
  end

  def quad_path; chosen.sort.map(&:realm).map(&:path).join("-"); end

end
