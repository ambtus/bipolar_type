class Answer

  def initialize(string)
    @path = string
    @question,@letters = string.split("_")
    @letters = "" unless @letters
  end
  attr_reader :path, :question, :letters

  def number; @question.last.to_i ; end

  def realms; @letters.scan(/./).collect{|l| Realm.find(l)}; end

  def subtypes; realms.add(Attitude.all.values_at(0,2,1)) + [unchosen.first + Attitude.find("ij")]; end

  def unchosen; Realm.all - realms; end

  def next(string); question.next + "_" + letters + string; end

  def quad_path; subtypes[0,4].sort_by{|s| s.attitude}.map(&:realm).map(&:path).join; end

end
