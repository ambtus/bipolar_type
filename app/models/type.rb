class Type

  def initialize(string)
    @mbti = string
    @realms = string.chars.collect{|s| Realm.send(s)}
    @realms.check_constraints(Realm, 1, 4)
  end
  attr_reader :mbti, :realms
  alias path :mbti
  alias inspect :mbti

  def name; mbti.chars.values_at(2,0,1,3).join; end

  ALL = Realm.all.permutation(4).collect{|perm| new(perm.map(&:mbti).join)}.flatten
  def index; ALL.index self; end

  ALL.each_with_index do |type, index|
    define_singleton_method(type.path) {Type.all[index]}
    define_singleton_method(type.path.downcase) {Type.all[index]}
  end

  class << self
    def all; ALL; end
    def each(&block); ALL.each(&block); end
    def my_path; 'TNFS'; end
    def my_type; Type.send(my_path); end
    def generic; Type.new(Realm.generic.mbti * 4); end
  end

  def eustresses; @realms.collect.each_with_index {|r, i| Subtype.eustress(r, i)}; end
  def doms; eustresses.values_at(2,0,1,3); end
  def <=>(other); doms.map(&:realm) <=> other.doms.map(&:realm); end

  def sixteen; eustresses.collect {|subtype| subtype.cycle.subtypes}.flatten.sort; end
end

