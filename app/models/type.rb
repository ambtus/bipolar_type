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
    def my_path; 'FTSN'; end
    def my_type; Type.send(my_path); end
  end

  def inferiors; @realms.add(Behavior.all).map(&:make_inferior); end
  def dominants; @realms.values_at(1,3,0,2).add(Behavior.all).map(&:make_dominant); end
  def tertiaries; dominants.map(&:make_tertiary).values_at(1,3,0,2); end
  def auxiliaries; inferiors.map(&:make_auxiliary).values_at(2,0,3,1); end

  # TODO there must be a better way to do this.
  def arrys; [auxiliaries,dominants,tertiaries,inferiors]; end
  def sixteen; arrys.map(&:first) + arrys.map(&:second) + arrys.map(&:third) + arrys.map(&:fourth); end
end

