class Type

  def self.my_path; "odma"; end
  def self.my_type; self.new my_path; end

  def initialize(string)
    @path = string
    @states = @path.scan(/./).collect{|a| State.send(a)}
    @states.check_constraints State, 4, 4
  end
  attr_reader :path, :states

  def subtypes; states.add(Energy.all).sort; end

  def symbol; subtypes.map(&:symbol).join("•"); end
  def inspect; symbol; end
  def name; symbol; end

  Energy.paths.each_with_index do |energy_path, index|
    define_method(energy_path) {subtypes[index]}
  end

end
