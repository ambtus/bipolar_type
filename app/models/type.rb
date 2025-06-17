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
    def sorted; all.sort_by{|t| t.episodes}; end
  end

  def name; realms.map(&:name).join('•'); end

  def symbol; realms.map(&:string).join('•'); end
  alias inspect :symbol

  def dos; realms.add(Attitude.all); end
  def donts; dos.map(&:flop); end
  def mores; dos.map(&:flip); end
  def episodes; dos.map(&:opposite).sort; end

  def bl_realms; realms.values_at(1,0,3,2); end
  def tr_realms; realms.values_at(0,1,2,3); end
  def br_realms; realms.values_at(2,3,0,1); end
  def tl_realms; realms.values_at(3,2,1,0); end

end

