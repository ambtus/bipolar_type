class Type

  def initialize(string)
    @focus_string = string
    @foci = string.chars.collect{|s| Focus.find_by(s)}
  end
  attr_reader :focus_string, :foci

  ALL = Focus.all.permutation(4).collect do |foci|
          Type.new(foci.map(&:symbol).join)
        end
  def index; ALL.index self; end
  def <=>(other); self.index <=> other.index; end
  alias path :focus_string

  class << self
    def all; ALL; end
    def each(&block); ALL.each(&block); end
    def title; all.count.to_s; end
    def find(string); all.find{|t| t.focus_string == string}; end
    def my_path; 'FTSN'; end
    def my_type; find(my_path); end
    def sort_by(index); all.sort_by{|t| t.foci[index]}.in_groups_of(6).map(&:sort).flatten; end
  end

  def problems; foci.add(State.all).flatten; end

  alias inspect :problems

  def symbol; problems.map(&:symbol).join('•'); end

  def find_problem(state); problems.find{|p| p.state == state}; end

end

