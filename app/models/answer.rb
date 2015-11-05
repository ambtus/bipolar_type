class Answer

  def self.test; Answer.new("Q2_is"); end

  def initialize(string)
    @question,@answer = string.split("_")
    @answer = "" unless @answer
  end
  attr_reader :question, :answer

  def number; @question.last.to_i ; end
  def finished?; number == 4; end

  def attitude; @answer.first; end
  def realm_paths; @answer.chip; end

  def chosen; realm_paths.scan(/./).collect{|r| Realm.find(r)}; end

  def realms; Realm.all - chosen; end

  def next(string); question.next + "_" + answer + string; end

  def result; attitude + realms.last.path + realm_paths.reverse ; end

end
