class Type

  def initialize(string)
    @symbol = string
    @realms = string.chars.collect{|s| Realm.send(s)}
    @realms.check_constraints(Realm, 4, 4)
  end
  attr_reader :symbol, :realms, :dominant_realm

  def inspect; @symbol; end
  def path; inspect ; end

  ALL = Realm.all.permutation(4).collect{|perm| new(perm.map(&:symbol).join)}.flatten
  def index; ALL.index self; end

  ALL.each_with_index do |type, index|
    define_singleton_method(type.path) {Type.all[index]}
    define_singleton_method(type.path.downcase) {Type.all[index]}
  end

  class << self
    def all; ALL; end
    def each(&block); ALL.each(&block); end
    def my_path; 'MFPA'; end
    def my_type; Type.send(my_path); end
  end

  def first_subtypes; @realms.add(Behavior.first); end
  def second_subtypes; @realms.values_at(2,0,3,1).add(Behavior.second); end
  def third_subtypes; @realms.values_at(1,3,0,2).add(Behavior.third); end
  def fourth_subtypes; @realms.reverse.add(Behavior.fourth); end

  def sixteen; first_subtypes + second_subtypes + third_subtypes + fourth_subtypes; end
end

