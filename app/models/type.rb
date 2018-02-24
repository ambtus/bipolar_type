class Type

  def self.my_path; "ims-ier-dfs-dpr"; end
  def self.my_type; self.new my_path; end

  def initialize(string)
    @path = string
    @subtypes = @path.split('-').collect{|s| Subtype.send(s)}
    @subtypes.map(&:realm).uniq.check_constraints Realm, 4, 4
  end
  attr_reader :path, :subtypes

  def symbol; subtypes.map(&:symbol).join("•"); end
  def inspect; symbol; end

  def name; symbol; end

end
