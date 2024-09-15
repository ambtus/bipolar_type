class Type

  def initialize(string)
    @aspect_string = string
    @aspects = string.chars.collect{|s| Aspect.send(s)}
  end
  attr_reader :aspect_string, :aspects

  def compulsions; aspects.add(Phase.linear); end
  def symbolic_name; compulsions.map(&:respond).join('•'); end
  alias inspect :symbolic_name

  def flips; compulsions.map(&:flip); end
  def flops; compulsions.map(&:flop); end
  def flip_flops; compulsions.map(&:opposite); end
  def sorted; (flips + flops + flip_flops + compulsions); end

  Phase::ORDINAL.each do |ordinal|
    define_method(ordinal) {sorted.select{|b| b.phase.ordinal == ordinal}}
  end

  def sixteen; [second, third, first, fourth]; end

  ALL = Aspect.all.permutation(4).collect do |aspects|
          Type.new(aspects.map(&:path).join)
        end
  def index; ALL.index self; end
  def <=>(other); self.index <=> other.index; end
  alias path :index

  class << self
    def all; ALL; end
    def each(&block); ALL.each(&block); end
    def find(index); all.find{|t| t.index == index}; end
    def find_by_aspect_string(string); all.find{|t| t.aspect_string == string}; end
    def my_path; 6; end
    def my_type; find(my_path); end
    def sort_by(linear_index); all.sort_by{|t| t.compulsions[linear_index].aspect.index}.in_groups_of(6).map(&:sort).flatten; end
  end

end

