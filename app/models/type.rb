class Type

  def initialize(string)
    @letters = string
    @realms = string.chars.collect{|s| Realm.send(s)}
    @realms.check_constraints(Realm, 1, 4)
  end
  attr_reader :letters, :realms

  alias name :letters
  alias path :letters
  alias inspect :letters

  ALL = Realm.all.permutation(4).collect{|perm| new(perm.map(&:letter).join)}.flatten
  def index; ALL.index self; end

  ALL.each_with_index do |type, index|
    define_singleton_method(type.path) {Type.all[index]}
    define_singleton_method(type.path.downcase) {Type.all[index]}
  end

  class << self
    def all; ALL; end
    def each(&block); ALL.each(&block); end
    def my_path; 'PAFM'; end
    def my_type; Type.send(my_path); end
    def generic; Type.new(Realm.generic.letter * 4); end
  end

  def compulsions; @realms.add(Behavior.all).add(Priority.last); end
  def four_by_four; compulsions.map(&:cycle).map(&:subtypes); end

end

