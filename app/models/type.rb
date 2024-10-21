class Type

  def initialize(string)
    @thing_string = string
    @things = string.chars.collect{|s| Thing.find_by(s)}
  end
  attr_reader :thing_string, :things

  ALL = Thing.all.permutation(4).collect do |things|
          Type.new(things.map(&:symbol).join)
        end
  def index; ALL.index self; end
  def <=>(other); self.index <=> other.index; end
  def path; index + 1; end

  class << self
    def all; ALL; end
    def each(&block); ALL.each(&block); end
    def title; [all.count, name.pluralize].to_phrase; end
    def find(string); all.find{|t| t.index == string.to_i-1}; end
    def find_by_thing_string(string); all.find{|t| t.thing_string == string}; end
    def my_path; '3'; end
    def my_type; find(my_path); end
    def sort_by(index); all.sort_by{|t| t.things[index]}.in_groups_of(6).map(&:sort).flatten; end
  end

  def subtypes; things.add(Tendency.all).flatten; end

  alias inspect :subtypes

  def symbol; subtypes.map(&:symbol).join('•'); end

  def find_subtype(tendency); subtypes.find{|p| p.tendency == tendency}; end

  def ep; subtypes.find{|p| p.tendency.symbol == 'EP'}; end
  def ip; subtypes.find{|p| p.tendency.symbol == 'IP'}; end
  def ej; subtypes.find{|p| p.tendency.symbol == 'EJ'}; end
  def ij; subtypes.find{|p| p.tendency.symbol == 'IJ'}; end

end

