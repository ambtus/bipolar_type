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
    def title; return name.pluralize; all.count.to_s; end
    def find(string); all.find{|t| t.focus_string == string}; end
    def my_path; 'FTSN'; end
    def my_type; find(my_path); end
    def sort_by(index); all.sort_by{|t| t.foci[index]}.in_groups_of(6).map(&:sort).flatten; end
  end

  def behaviors; foci.add(State.all).flatten; end
  def flip_behaviors; behaviors.values_at(0,2,3,1); end
  def flop_behaviors; behaviors.values_at(3,1,0,2); end
  def opposite_behaviors; behaviors.values_at(1,3,2,0); end

  alias inspect :behaviors

  def symbol; behaviors.map(&:symbol).join('•'); end

  def find_behavior(thing)
    if thing.is_a?(State)
      behaviors.find{|p| p.state == thing}
    elsif thing.is_a?(Focus)
      behaviors.find{|p| p.focus == thing}
    end
  end

end

