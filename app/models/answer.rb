class Answer

  def self.first_path; "Q1"; end
  def self.first; Answer.new(first_path); end

  def initialize(string)
    @question,realms = string.split(":")
    @realm_paths = (realms || "").scan(/./)
  end
  attr_reader :question, :realm_paths

  def number; @question.last.to_i ; end
  def finished?; number == 4; end

  def chosen; realm_paths.collect{|path| Realm.send(path)}; end
  def first; chosen.first; end
  def second; chosen.second; end
  def pair; chosen[0,2]; end
  def overs; Realm.all - pair; end
  def third; overs.first; end
  def fourth; overs.second; end

  def chosen?(realm); chosen.include? realm; end

  def paths(realms); realms.map(&:path).join; end
  def two(realms); "#{question.next}:#{paths(realms)}"; end
  def three(realms); "#{question.next}:#{paths(realms)}"; end
  def four(realms); "#{question.next}:#{paths(pair)}#{paths(realms)}"; end

  def quad_path; chosen.map(&:path).join; end

end
