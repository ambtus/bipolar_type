class Answer

  def self.first_path; "Q1"; end
  def self.first; Answer.new(first_path); end

  def initialize(string)
    @question,@attitude_letters = string.split(":")
  end
  attr_reader :question, :attitude_letters

  def number; @question.last.to_i ; end
  def finished?; number == 9; end
  def realm; Realm.all[(number - 1)/2]; end

  def next(letter); "#{question.next}:#{attitude_letters}#{letter}"; end

  def attitudes; attitude_letters.scan(/../).collect{|s| Attitude.send(s)}; end
  def subtypes; attitudes.add(Realm.all); end
  def quad_path; subtypes.sort.map(&:path).join("-"); end

end
