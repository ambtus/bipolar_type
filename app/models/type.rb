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
    def my_path; '15'; end
    def my_type; find(my_path); end
    def sort_by(index); all.sort_by{|t| t.subtypes[index]}.in_groups_of(6).map(&:sort).flatten; end
  end

  def subtypes; things.add(Help.all.map(&:tendency)).flatten; end

  def symbol; subtypes.map(&:symbol).join('•'); end

  alias inspect :symbol

  def find_subtype(symbol); subtypes.find{|p| p.tendency.symbol == symbol}; end

  Tendency::SYMBOL.each do |symbol|
    define_method(symbol.downcase) {find_subtype(symbol)}
  end

  def subtypes_by(index)
    case index
    when 0
      [ep, ip, ej, ij]
    when 1
      [ij, ej, ip, ep]
    when 2
      [ej, ij, ep, ip]
    when 3
      [ip, ep, ij, ej]
    end
  end

end

