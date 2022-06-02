class Type

  def initialize(emoji)
    @symbol = emoji
    @realms = @symbol.scan(/./).collect{|x| Realm.send(x)}
    @realms.uniq.check_constraints Realm, 4, 4
  end
  attr_reader :symbol, :realms

  ALL = Realm.symbols.permutation(4).map(&:join).collect{|p| new(p)}
  class << self
    def all; ALL; end
    def each(&block); ALL.each(&block); end
    def my_realms; "🤑🥰😷🧐"; end
    def my_type; ALL.find{|type| type.symbol == my_realms}; end
  end

  def inspect; @symbol; end
  def manic_realm; @realms.first; end
  def receptive_realm; @realms.second; end
  def depressed_realm; @realms.third; end
  def productive_realm; @realms.fourth; end
  def path; @symbol; end

  def descriptions; ["#{manic_realm.symbol}
↗️","#{receptive_realm.symbol}↘️","#{depressed_realm.symbol}↙️
","#{productive_realm.symbol}↖️"]; end

  def description; descriptions.join(", "); end

end

