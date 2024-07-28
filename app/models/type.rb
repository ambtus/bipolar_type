class Type

  def initialize(string)
    @realms = string.chars[0,4].collect{|s| Realm.send(s)}
    @dominant_realm = Realm.send(string.last)
    @symbol = string
  end
  attr_reader :symbol, :realms, :dominant_realm

  def inspect; @symbol; end
  def path; inspect ; end

  ALL = Realm.all.permutation(4).collect{|perm| Realm.all.collect{|realm| new(perm.map(&:symbol).join + realm.symbol)}}.flatten
  def index; ALL.index self; end

  ALL.each_with_index do |type, index|
    define_singleton_method(type.path) {Type.all[index]}
    define_singleton_method(type.path.downcase) {Type.all[index]}
  end

  class << self
    def all; ALL; end
    def each(&block); ALL.each(&block); end
    def my_path; 'MAPFA'; end
    def my_type; Type.send(my_path); end
  end

  def subtypes; @realms[0,4].add(Problem.all); end
  def dominant; subtypes.find{|s| s.realm == @dominant_realm}; end
  def doubled; subtypes + subtypes; end
  def dindex; doubled.index(dominant); end
  def auxiliary; doubled[dindex + 2]; end
  def tertiary; doubled[dindex + 3]; end
  def inferior; doubled[dindex + 1]; end


end

