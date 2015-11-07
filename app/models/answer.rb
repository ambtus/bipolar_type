class Answer

  def self.first_path; "Q1"; end
  def self.first; Answer.new(first_path); end

  def initialize(string)
    @question,@answer = string.split("_")
    @answer = "" unless @answer
  end
  attr_reader :question

  def number; @question.last.to_i ; end
  def finished?; number == 4; end

  def attitude; @answer.first; end
  def realm_paths; @answer.chip; end

  def chosen; realm_paths.scan(/./).collect{|r| Realm.find(r)}; end

  def realms; Realm.all - chosen; end

  def next(string); question.next + "_" + @answer + string; end

  def priorities; (realms + chosen.reverse); end
  def quad; Quad.find(attitude + priorities.map(&:path).join); end
  def result; quad.path; end

end
