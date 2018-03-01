class Type

  def self.my_path; "sfnt"; end
  def self.my_type; self.new my_path; end

  def initialize(string)
    @path = string
    @realms = @path.scan(/./).collect{|r| Realm.send(r)}
    @realms.uniq.check_constraints Realm, 4, 4
  end
  attr_reader :path, :realms

  def subtypes; realms.add(Attitude.all); end

  def symbol; subtypes.map(&:symbol).join("•"); end
  def inspect; symbol; end

  def name; symbol; end

  def self.all;Realm.paths.permutation(4).sort_by{|x| [x.first, x.fourth]}.map(&:join).collect{|p| new(p)};end

end
