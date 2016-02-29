class Answer

  def self.first_path; "Q1"; end
  def self.first; Answer.new(first_path); end

  def initialize(string)
    @question,realms = string.split(":")
    @realm_paths = (realms || "").split("-")
  end
  attr_reader :question, :realm_paths

  def number; @question.last.to_i ; end
  def finished?; number == 5; end

  def chosen; realm_paths.collect{|path| Realm.send(path)}; end

  def chosen?(realm); chosen.include? realm; end

  def all(realm); chosen << realm; end
  def paths(realm); all(realm).map(&:path).join('-'); end
  def next(realm); "#{question.next}:#{paths(realm)}"; end

  def quad_path; chosen.values_at(2,0,1,3).map(&:path).join("-"); end

end
