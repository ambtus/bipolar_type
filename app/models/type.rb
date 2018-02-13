class Type

  def self.my_path; "apvc"; end
  def self.my_type; self.new my_path; end

  def initialize(string)
    @path = string
    @imbalances = @path.scan(/./).collect{|a| Imbalance.send(a)}
    @imbalances.check_constraints Imbalance, 4, 4
  end
  attr_reader :path, :imbalances

  def subtypes; imbalances.add(Energy.all).sort; end

  def symbol; subtypes.map(&:symbol).join("•"); end
  def inspect; symbol; end
  def name; symbol; end

  Energy.paths.each_with_index do |energy_path, index|
    define_method(energy_path) {subtypes[index]}
  end

end
