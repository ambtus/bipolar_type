class Type

  def self.my_path; "bdac"; end
  def self.my_type; self.new my_path; end

  def initialize(string)
    @path = string
    @realms = @path.scan(/./).collect{|x| Realm.send(x)}
    @realms.uniq.check_constraints Realm, 4, 4
  end
  attr_reader :path, :realms

  %w{first second third fourth}.each_with_index do |ordinal, index|
    define_method(ordinal) {@realms[index]}
  end

  def subtypes; realms.add(Attitude.all); end

  def symbol; realms.map(&:symbol).join; end
  def inspect; symbol; end

  def name; symbol; end

  def self.all;Realm::PATHS.permutation(4).map(&:join).collect{|p| new(p)};end

  def get_mores; subtypes.values_at(0,3); end
  def get_lesses; subtypes.values_at(1,2); end
  def use_mores; subtypes.values_at(2,3); end
  def use_lesses; subtypes.values_at(0,1); end


end

