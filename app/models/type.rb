class Type

  def initialize(string)
    @function_string = string
    @functions = string.chars.collect{|s| Function.send(s)}
  end
  attr_reader :function_string, :functions

  alias inspect :function_string
  def name
    "#{functions.first.externalize.s} and #{functions.third.internalize.s} “too much”<br />dosen’t #{functions.second.internalize} or #{functions.fourth.externalize} “enough”".html_safe
  end

  ALL = Function.all.permutation(4).collect do |functions|
          Type.new(functions.map(&:path).join)
        end
  def index; ALL.index self; end
  def <=>(other); self.index <=> other.index; end
  alias path :function_string

  class << self
    def all; ALL; end
    def each(&block); ALL.each(&block); end
    def find(string); all.find{|t| t.function_string == string}; end
    def my_path; 'FTNS'; end
    def my_type; find(my_path); end
    def sort_by(index); all.sort_by{|t| t.functions[index]}.in_groups_of(6).map(&:sort).flatten; end
  end

end

