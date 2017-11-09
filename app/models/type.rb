class Type

  def self.my_path; Attitude.all.map(&:path).join("-"); end
  def self.first; self.new my_path; end

  def initialize(string)
    @path = string
    @attitudes = @path.split("-").collect{|a| Attitude.send(a)}
    @attitudes.check_constraints Attitude, 4, 4
  end
  attr_reader :path, :attitudes

  def subtypes; attitudes.add(Realm.all); end
  def name; subtypes.map(&:name).join("•"); end
  def inspect; name; end

end
