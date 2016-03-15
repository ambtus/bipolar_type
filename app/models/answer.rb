class Answer

  def self.first_path; "Q1"; end
  def self.first; Answer.new(first_path); end

  def initialize(string)
    @question,@answer = string.split(":")
    @realm_paths = (@answer || "").scan(/./)
  end
  attr_reader :question, :realm_paths

  def number; @question.last.to_i ; end
  def finished?; number == 4; end

  def chosen; realm_paths.collect{|path| Realm.send(path)}; end
  def chosen?(realm); chosen.include? realm; end
  def unchosen; Realm.all - chosen; end

  def next(realm); "#{question.next}:#{@answer}#{realm.path}"; end

  def first; [chosen.first, *unchosen, chosen.second]; end
  def second; [chosen.first, *unchosen.reverse, chosen.second]; end
  def first_path; first.map(&:path).join; end
  def second_path; second.map(&:path).join; end
  def first_quad; Quad.send(first_path); end
  def second_quad; Quad.send(second_path); end
end
