class Answer

  def self.first_path; "Q1"; end
  def self.first; Answer.new(first_path); end

  def initialize(string)
    @question,@subtype_paths = string.split(":")
  end
  attr_reader :question, :subtype_paths

  def number; @question.last.to_i ; end
  def finished?; number == 5; end
  def realm; Realm.all[number - 1]; end

  def next(subtype); "#{question.next}:#{subtype_paths}#{subtype.path}"; end

  def subtypes; subtype_paths.scan(/../).collect{|s| Subtype.send(s)}; end
  def quad_path; subtypes.sort.map(&:path).join; end

end
