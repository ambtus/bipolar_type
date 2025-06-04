class Type

  def initialize(string)
    @realm_string = string
    @realms = string.chars.collect{|s| Realm.find_by(s)}
  end
  attr_reader :realm_string, :realms

  ALL = Realm.all.permutation(4).collect do |realms|
          Type.new(realms.map(&:symbol).join)
        end
  def index; ALL.index self; end
  def <=>(other); self.index <=> other.index; end
  def path; index + 1; end

  class << self
    def all; ALL; end
    def each(&block); ALL.each(&block); end
    def title; [all.count, name.pluralize].to_phrase; end
    def find(string); all.find{|t| t.index == string.to_i-1}; end
    def find_by_realm_string(string); all.find{|t| t.realm_string == string}; end
    def my_path; '4'; end
    def my_type; find(my_path); end
    def sort_by(index); all.sort_by{|t| t.subtypes[index]}.in_groups_of(6).map(&:sort).flatten; end
  end

  def subtypes; realms.add(Attitude.all); end

  def subtype_symbols; subtypes.map(&:symbol); end
  def symbol; subtype_symbols.join('•'); end

  alias inspect :symbol

  def subtype_for(attitude); subtypes[attitude.index]; end

end

