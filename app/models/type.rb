class Type

  def initialize(string)
    @realm_string = string
    @realms = string.chars.collect{|s| Realm.find(s)}
  end
  attr_reader :realm_string, :realms
  alias path :realm_string

  ALL = Realm.all.permutation(4).collect do |realms|
          Type.new(realms.map(&:symbol).join)
        end

  class << self
    def all; ALL; end
    def each(&block); ALL.each(&block); end
    def title; [all.count, name.pluralize].to_phrase; end
    def find(string); all.find{|t| t.realm_string == string}; end
    def my_path; 'FTNS'; end
    def your_path; 'TFSN'; end
    def my_type; find(my_path); end
    def your_type; find(your_path); end
  end

  def name; realms.map(&:name).join('•'); end

  def symbol; realms.map(&:string).join('•'); end
  alias inspect :symbol

  def subtypes; realms.add(Attitude.all); end


end

