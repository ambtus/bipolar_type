class Type

  def self.my_path; "fstn"; end
  def self.my_type; self.new my_path; end

  def initialize(string)
    @path = string
    @realms = @path.scan(/./).collect{|x| Realm.send(x)}
    @realms.uniq.check_constraints Realm, 4, 4
  end
  attr_reader :path, :realms

  def subtypes; realms.add(Attitude.all); end

  def symbol; subtypes.map(&:mbti).join("•"); end
  def inspect; symbol; end
  def name; symbol; end

  def self.all;Realm::PATHS.permutation(4).map(&:join).collect{|p| new(p)};end

  Attitude.all.map(&:symbol).each_with_index do |symbol, index|
    define_method(symbol) {subtypes[index]}
  end

end

