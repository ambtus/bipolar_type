class Type

  def initialize(string)
    @realm_string = string
    @realms = string.chars.collect{|s| Realm.find(s)}
    @realms.uniq.check_constraints(Realm,min=4,max=4)
  end
  attr_reader :realm_string, :realms
  alias path :realm_string
  alias inspect :realm_string

  ALL = Realm.all.permutation(4).collect do |realms|
          Type.new(realms.map(&:symbol).join)
        end

  class << self
    def all; ALL; end
    def each(&block); ALL.each(&block); end
    def title; [all.count, name.pluralize].to_phrase; end
    def find(string); all.find{|t| t.realm_string == string}; end
    def find_by_tlas(string);
      tlas = string.scan(/.../)
      subtypes = tlas.collect{|tla| Subtype.find_by_tla(tla)}
      Rails.logger.debug {"subtypes: #{subtypes}"}
      ALL.find{|t| t.problems[0,3] == subtypes.sort}
    end
    def my_path; 'SFTN'; end
    def your_path; my_path.reverse; end # for tests, just needs to be different.
    def my_type; find(my_path); end
    def your_type; find(your_path); end
  end

  def problems; realms.add(Attitude.all); end

  def p1; realms.second; end
  def p2; realms.third; end
  def j1; realms.fourth; end
  def j2; realms.first; end

end

