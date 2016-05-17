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
  def description; Word.new(%w{consumer bored stressed producer}[index]); end
  def letter; description.first; end
  ALL.each{|s| define_singleton_method(s.letter) {s}}

  def mbti; %w{P E I J}[index]; end

  def prefix(realm); diagonal? ? realm.adjective : realm.adverb; end
  def name(realm); Phrase.new [prefix(realm), description].map(&:titleize); end
end
