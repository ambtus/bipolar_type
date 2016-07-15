class Type

  def self.my_path; "ipc-imp-ssc-sfp"; end
  def self.first; self.new my_path; end

  def initialize(string)
    @path = string
    @subtypes = @path.split("-").collect{|p| Subtype.send(p)}
    @subtypes.map(&:realm).uniq.check_constraints Realm, 4, 4
  end
  attr_reader :subtypes, :path
  def inspect; @subtypes.map(&:inspect).join("•"); end

  def name; subtypes.map(&:symbol).join("•"); end

end
