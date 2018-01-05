class Type

  def self.my_path; "ep-ej-ip-ij"; end
  def self.my_type; self.new my_path; end

  def initialize(string)
    @path = string
    @attitudes = @path.split("-").collect{|a| Attitude.send(a)}
    @attitudes.check_constraints Attitude, 4, 4
  end
  attr_reader :path, :attitudes

  def subtypes; attitudes.add(Realm.all).sort; end
  def symbol; subtypes.map(&:symbol).join("•"); end
  def inspect; symbol; end

  def name; symbol; end

  Realm.paths.each_with_index do |realm_path, index|
    define_method(realm_path) {subtypes[index]}
  end


end
