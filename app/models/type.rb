class Type

  def initialize(string)
    @realms = string.chars.collect{|s| Realm.send(s)}
  end
  attr_reader :realms

  def linear_solutions; realms.add(Quadrant.linear); end
  def solutions; linear_solutions.values_at(1,2,0,3); end

  def dominants; linear_solutions.map(&:flop).reverse; end
  def name; dominants.map(&:mbti).join('•'); end
  alias inspect :name

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
    def find_by_problems(behaviors); all.find{|t| t.dominants.without(behaviors).empty?}; end
    def my_path; 15; end
    def my_type; find(my_path); end
    def sort_by(qi); all.sort_by{|t| t.dominants[qi].realm.index}.in_groups_of(6).map(&:sort).flatten; end
  end

end

