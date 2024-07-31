class Type

  def initialize(string)
    @mbti = string
    @realms = string.chars.collect{|s| Realm.send(s)}
    @realms.check_constraints(Realm, 1, 4)
  end
  attr_reader :mbti, :realms
  alias path :mbti
  alias inspect :mbti

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

  def dominants; @realms.collect.each_with_index {|r, i| Subtype.new(Behavior.sort_order[i], r, Position.dominant)}; end

  def sixteen; dominants.collect {|subtype| subtype.cycle.subtypes}.flatten.sort; end
end

