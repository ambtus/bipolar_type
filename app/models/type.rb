class Type

  def initialize(array)
    @realms = array.collect{|s| Realm.send(s)}
    @symbol = array.join
  end
  attr_reader :symbol, :realms

  ALL = Realm.symbols.permutation(4).collect{|p| new(p)}
  class << self
    def all; ALL; end
    def each(&block); ALL.each(&block); end
    def my_realm_strings; %w{F S T N}; end
    def my_type; ALL.find{|type| type.realms.map(&:path) == my_realm_strings}; end
  end

  def inspect; @symbol; end
  def path; inspect ; end
  def index; ALL.index self; end

  def subtypes; 4.times.collect{|i| Subtype.select(@realms[i], Position.all[i])}; end

end

