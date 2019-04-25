class Answer

  def self.first_path; "Q1"; end
  def self.first; Answer.new(first_path); end

  def initialize(string)
    @question,realms = string.split(":")
    @realm_paths = (realms || "").chars
  end
  attr_reader :question, :realm_paths

  def number; @question.last.to_i ; end
  def index; number - 1; end
  def finished?; number > 4; end

  def taken; realm_paths.collect{|path| Realm.send(path)}; end
  def realms; (Realm.all - taken); end

  def all(realm); taken << realm; end
  def paths(realm); all(realm).map(&:path).join; end
  def next(realm); "#{question.next}:#{paths(realm)}"; end

  def type_path; realm_paths.values_at(2,3,0,1).join; end
end
