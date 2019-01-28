class Answer

  def self.first_path; "Q1"; end
  def self.first; Answer.new(first_path); end

  def initialize(string)
    @question,subtypes = string.split(":")
    @subtype_paths = (subtypes || "").split("-")
  end
  attr_reader :question, :subtype_paths

  def number; @question.last.to_i ; end
  def index; number - 1; end
  def finished?; number > 4; end

  def chosen; subtype_paths.collect{|path| Subtype.send(path)}; end
  def constrained; chosen.map(&:siblings).flatten.uniq; end

  def css(subtype)
    if chosen.include? subtype
      "chosen"
    elsif constrained.include? subtype
      "warning"
    else
      "free"
    end
  end

  def all(subtype); chosen << subtype; end
  def paths(subtype); all(subtype).map(&:path).join('-'); end
  def next(subtype); "#{question.next}:#{paths(subtype)}"; end

  def subtypes; (Subtype.all - constrained).sort; end
  def type_path; subtypes.map(&:realm).map(&:path).join; end

end
