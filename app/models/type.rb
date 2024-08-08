class Type

  def initialize(string)
    @mbti = string
    @realms = string.chars.collect{|s| Realm.send(s)}
    @realms.check_constraints(Realm, 1, 4)
  end
  attr_reader :mbti, :realms


  def name; mbti.chars.values_at(2,0,1,3).join; end
  alias path :name
  alias inspect :name

  ALL = Realm.all.permutation(4).collect{|perm| new(perm.map(&:mbti).join)}.flatten
  def index; ALL.index self; end

  ALL.each_with_index do |type, index|
    define_singleton_method(type.path) {Type.all[index]}
    define_singleton_method(type.path.downcase) {Type.all[index]}
  end

  class << self
    def all; ALL; end
    def each(&block); ALL.each(&block); end
    def my_path; 'SFTN'; end
    def my_type; Type.send(my_path); end
    def generic; Type.new(Realm.generic.mbti * 4); end
  end

  def compulsions; @realms.add(Behavior.sort_order).add(State.compulsion); end
  def foci; compulsions.values_at(3,1,0,2); end
  def <=>(other); foci.map(&:realm) <=> other.foci.map(&:realm); end

  def cycles; compulsions.map(&:cycle); end
  def sixteen; cycles.map(&:subtypes).flatten.sort; end
end

