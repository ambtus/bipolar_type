class Type

  def self.my_path; "FAMP"; end
  def self.my_type; self.new my_path; end

  def initialize(string)
    @symbol = string
    @realms = string.scan(/./).collect{|x| Realm.send(x)}
    @realms.check_constraints Realm, 4, 4
  end
  attr_reader :symbol, :realms

  ALL = Realm::SYMBOLS.permutation(4).collect{|x| new(x.join)}

  def subtypes; realms.add(Solution.all); end

  def inspect; @symbol; end
end
