class Type

  def self.my_path; "ep-ej-ip-ij"; end
  def self.mine; self.new my_path; end

  def initialize(string)
    @path = string
    @attitudes = @path.split("-").collect{|a| Attitude.send(a)}
    @attitudes.check_constraints Attitude, 4, 4
  end
  attr_reader :path, :attitudes

  def subtypes; attitudes.add(Realm.all); end
  def mbti; subtypes.map(&:mbti).join("•"); end
  def inspect; mbti; end

  def name; mbti; end

end
