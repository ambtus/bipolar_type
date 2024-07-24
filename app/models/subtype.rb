class Subtype

  def initialize(realm, problem)
    @realm = realm
    @problem = problem
  end
  attr_reader :realm, :problem

  def pair; [@realm, @problem]; end
  def symbol; pair.map(&:symbol).join; end
  alias path :symbol
  def inspect; pair.map(&:name).to_phrase; end

  ALL = Problem.all.collect do |problem|
          Realm.all.collect do |realm|
            self.new(realm,problem)
          end
        end.flatten

  class << self
    def find(string); ALL.find{|s| s.path == string}; end
    def select(realm, problem); ALL.find{|s| s.realm == realm && s.problem == problem}; end
    def all; ALL; end
    def each(&block); ALL.each(&block); end
  end

  ALL.each_with_index do |subtype, index|
    define_singleton_method(subtype.path) {Subtype.all[index]}
    define_singleton_method(subtype.path.downcase) {Subtype.all[index]}
  end

  def adjective; [@realm.adverb, @problem.adjective].to_phrase; end
  def noun; [@realm.adjective, @problem.noun].to_phrase; end

  def name; noun.titleize; end


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
