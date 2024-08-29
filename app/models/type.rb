class Type

  def initialize(string)
    @path = string
    @realms = string.chars.collect{|s| Realm.send(s)}
  end
  attr_reader :path, :realms

  def behaviors; realms.add(Quadrant.all); end

  def linear_behaviors; behaviors.values_at(2,0,1,3); end
  def problems; linear_behaviors.map(&:flop); end
  def inspect; problems.map(&:mbti).reverse.join('•'); end
  alias name :inspect

  ALL = Realm.all.permutation(4).collect do |realms|
          Type.new(realms.map(&:path).join)
        end

  class << self
    def all; ALL; end
    def each(&block); ALL.each(&block); end
    def find(path); all.find{|t| t.path == path}; end
    def my_path; 'TFNS'; end
    def my_type; Type.find(my_path); end
  end

end

