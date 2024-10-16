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
    def title; [all.count, name.pluralize].to_phrase; end
    def find(string); all.find{|t| t.focus_string == string}; end
    def my_path; 'FTSN'; end
    def my_type; find(my_path); end
    def sort_by(index); all.sort_by{|t| t.foci[index]}.in_groups_of(6).map(&:sort).flatten; end
  end

  def solutions; foci.add(State.all).flatten; end

  alias inspect :solutions

  def symbol; solutions.map(&:symbol).join('•'); end

  def find_solution(state); solutions.find{|p| p.state == state}; end

  def ep; solutions.find{|p| p.state.symbol == 'EP'}; end
  def ip; solutions.find{|p| p.state.symbol == 'IP'}; end
  def ej; solutions.find{|p| p.state.symbol == 'EJ'}; end
  def ij; solutions.find{|p| p.state.symbol == 'IJ'}; end

end

