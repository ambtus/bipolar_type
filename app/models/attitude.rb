class Attitude < Phrase

  def initialize(array)
    @sensitivity = array.first
    @tendency = array.second
    super
  end
  attr_reader :sensitivity, :tendency

  ALL = Sensitivity::ALL.collect do |sensitivity|
          Tendency::ALL.collect do |tendency|
            self.new [sensitivity,tendency]
          end
        end.flatten

  def self.all; ALL; end
  def words; [sensitivity, tendency]; end
  def path; words.join.to_s; end
  def inspect; Word.new path.upcase; end
  def to_s; inspect.to_s; end
  def to_str; to_s; end

  def quad; Quad.new Array.new(4, self).add(Realm.all).map(&:path).join("-"); end

  ALL.each{|s| define_singleton_method(s.path) {s}}
  def self.paths; ALL.map(&:path); end

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end
  def +(realm); subtypes.find{|s| s.realm == realm} || Subtype.new([realm, self]); end

  def method_missing(meth, *arguments, &block)
    if sensitivity.respond_to?(meth)
      sensitivity.send(meth, *arguments, &block)
    elsif tendency.respond_to?(meth)
      tendency.send(meth, *arguments, &block)
    else
      super
    end
  end

  def respond_to?(meth)
    sensitivity.respond_to?(meth) || tendency.respond_to?(meth) || super
  end

  def diagonal?; [0,3].include? index; end

  def index; ALL.index(self); end
  def ordinal; generic? ? "generic" : %w{first second third fourth}[index]; end

  def mbti; %w{P E I J}[index]; end

end
