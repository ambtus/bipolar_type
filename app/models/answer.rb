class Answer

  def self.first_path; "Q1"; end
  def self.first; Answer.new(first_path); end

  def initialize(string)
    @question,@realm_paths = string.split(":")
  end
  attr_reader :question, :realm_paths

  def number; @question.last.to_i ; end
  def finished?; number == 5; end

  def next(realm); "#{question.next}:#{realm_paths}#{realm.path}"; end

  def chosen; realm_paths.chars.collect{|r| Realm.send(r)}; end
  def realms; Realm.all - chosen; end

  def realms_in_order; chosen.values_at(0,2,3,1); end
  def subtypes; realms_in_order.add(Attitude.all); end
  def quad_path; subtypes.map(&:path).join("-"); end

end
