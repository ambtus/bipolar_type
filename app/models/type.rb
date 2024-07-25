class Type

  def initialize(array)
    @realms = array.collect{|s| Realm.send(s)}
    @symbol = array.join
  end
  attr_reader :symbol, :realms

  def inspect; @symbol; end
  def path; inspect ; end

  ALL = Realm::SYMBOLS.permutation(4).collect{|p| new(p)}
  def index; ALL.index self; end

  ALL.each_with_index do |type, index|
    define_singleton_method(type.path) {Type.all[index]}
    define_singleton_method(type.path.downcase) {Type.all[index]}
  end

  class << self
    def all; ALL; end
    def each(&block); ALL.each(&block); end
    def my_type; Type.FPAM; end
    def my_path; my_type.path; end
  end

  def subtypes; @realms.add(Problem.all); end

  def anorexic; subtypes.first; end
  def obese; subtypes.second; end
  def depressed; subtypes.third; end
  def manic; subtypes.fourth; end
end

