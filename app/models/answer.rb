class Answer

  def self.first_path; "Q1"; end
  def self.first; Answer.new(first_path); end

  def initialize(string)
    @question,realms = string.split(":")
    @realm_paths = realms || ""
  end
  attr_reader :question, :realm_paths

  def number; @question.last.to_i ; end
  def index; number - 1; end
  def finished?; number > 3; end

  def next(realm_path); "#{question.next}:#{realm_paths}#{realm_path}"; end

  def attitude; Attitude.all[index]; end

  def chosen; realm_paths.chars.collect{|path| Realm.send(path)}; end
  def realms; Realm.all - chosen; end
  def last_path; realms.last.path; end

  def type_path; realm_paths + last_path ; end

end
