class Answer

  def self.first_path; "Q1"; end
  def self.first; Answer.new(first_path); end

  def initialize(string)
    @question,@realm_paths = string.split(":")
    @realm_paths = @realm_paths || ""
  end
  attr_reader :question, :realm_paths

  def number; @question.last.to_i ; end
  def index; number - 1; end
  def solution; Solution.all[index]; end
  def behavior; Behavior.all[index]; end
  def finished?; number > 4; end

  def realms; @realm_paths.scan(/./).collect{|x| Realm.send(x)}; end
  def solutions; Solution.all[0..index]; end
  def subtypes; realms.add(solutions); end

  def chosen?(subtype); realms.include?(subtype.realm); end

  def css(subtype)
    chosen?(subtype) ? "chosen" : "free"
  end

  def paths(realm); [realm_paths, realm.symbol].join; end
  def next(realm); "#{question.next}:#{paths(realm)}"; end

  def type_path; @realm_paths; end


end
