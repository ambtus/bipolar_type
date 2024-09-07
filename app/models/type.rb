class Type

  def initialize(string)
    @realm_string = string
    @realms = string.chars.collect{|s| Realm.send(s)}
  end
  attr_reader :realm_string, :realms

  def dominants; realms.add(Phase.linear); end
  def symbolic_name; dominants.map(&:mbti).join('•'); end
  alias inspect :symbolic_name

  def problems; dominants.values_at(1,2,0,3); end
  def solutions; problems.map(&:flop).sort; end

  ALL = Realm.all.permutation(4).collect do |realms|
          Type.new(realms.map(&:path).join)
        end
  def index; ALL.index self; end
  def <=>(other); self.index <=> other.index; end
  alias path :index

  class << self
    def all; ALL; end
    def each(&block); ALL.each(&block); end
    def find(index); all.find{|t| t.index == index}; end
    def find_by_realms(string); all.find{|t| t.realm_string == string}; end
    def my_path; 6; end
    def my_type; find(my_path); end
    def sort_by(qi); all.sort_by{|t| t.dominants[qi].realm.index}.in_groups_of(6).map(&:sort).flatten; end
  end

end

