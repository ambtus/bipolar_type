class Type

  def self.my_path; "abcd"; end
  def self.my_type; self.new my_path; end

  def initialize(string)
    @path = string
    @realms = @path.scan(/./).collect{|r| Realm.send(r)}
    @realms.uniq.check_constraints Realm, 4, 4
  end
  attr_reader :path, :realms

  %w{first second third fourth}.each_with_index do |ordinal, index|
    define_method(ordinal) {@realms[index]}
  end

  def subtypes; realms.add(Attitude.all); end

  def symbol; subtypes.map(&:symbol).join("•"); end
  def inspect; symbol; end

  def name; symbol; end

  def self.all;Realm::PATHS.permutation(4).map(&:join).collect{|p| new(p)};end

end

