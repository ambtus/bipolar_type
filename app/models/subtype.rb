class Subtype

  def initialize(problem, realm)
    @realm = realm
    @problem = problem
  end
  attr_reader :realm, :problem

  def pair; [@problem, @realm]; end
  def symbol; pair.map(&:symbol).join; end
  alias path :symbol

  def names; pair.map(&:name).map(&:to_words).flatten.values_at(0,2,1).map(&:titleize); end
  def name; names.wbr; end
  def inspect; names.to_phrase; end
  def symbolic_name; [symbol.colon, name].to_safe_phrase; end

  ALL = Problem.all.collect do |problem|
          Realm.all.collect do |realm|
            self.new(problem,realm)
          end
        end.flatten

  class << self
    def find(string); ALL.find{|s| s.path == string}; end
    def select(realm, problem); ALL.find{|s| s.realm == realm && s.problem == problem}; end
    def all; ALL; end
    def each(&block); ALL.each(&block); end
  end

  def mbti; pair.map(&:mbti).map(&:chars).flatten.values_at(0,2,1).join; end

  ALL.each_with_index do |instance, index|
    %w{symbol mbti}.each do |thing|
      define_singleton_method(instance.send(thing)) {ALL[index]}
      define_singleton_method(instance.send(thing).downcase) {ALL[index]}
    end
  end

  def problem_name; [@realm.adverb.capitalize, *@problem.problem_names].wbr; end

  def behavior; @realm.send(@problem.behavior); end

  def method_missing(meth, *arguments, &block)
    if realm.respond_to?(meth)
      realm.send(meth, *arguments, &block)
    elsif problem.respond_to?(meth)
      problem.send(meth, *arguments, &block)
    else
      super
    end
  end


end
