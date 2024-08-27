class Type

  def initialize(string)
    @path = string
    @behaviors = string.split('•').collect{|s| Behavior.send(s)}.sort
  end
  attr_reader :path, :behaviors

  def inspect; behaviors.map(&:display).join('•'); end
  alias name :inspect

  ALL = Realm.all.permutation(4).collect do |realms|
          Type.new(realms.add(Quadrant.all).map(&:display).join('•'))
        end

  class << self
    def all; ALL; end
    def each(&block); ALL.each(&block); end
    def find(path); all.find{|t| t.path == path}; end
    def my_path; 'ETP•ENJ•IFP•ISJ'; end
    def my_type; Type.find(my_path); end
  end

end

