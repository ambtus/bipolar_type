class Attitude < Phrase

  def initialize(array)
    @nature = array.first
    @nurture = array.second
    super
  end
  attr_reader :nature, :nurture

  ALL = Nature::ALL.collect do |nature|
          Nurture::ALL.collect do |nurture|
            self.new [nature,nurture]
          end
        end.flatten

  def self.all; ALL; end
  def words; [nature, nurture]; end
  def path; words.join.to_s; end
  def inspect; Word.new path.upcase; end
  def to_s; inspect.to_s; end
  def to_str; to_s; end

  ALL.each{|s| define_singleton_method(s.path) {s}}
  def self.paths; ALL.map(&:path); end

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end
  def +(realm); subtypes.find{|s| s.realm == realm} || Subtype.new([realm, self]); end

  def method_missing(meth, *arguments, &block)
    if nature.respond_to?(meth)
      nature.send(meth, *arguments, &block)
    elsif nurture.respond_to?(meth)
      nurture.send(meth, *arguments, &block)
    else
      super
    end
  end

  def respond_to?(meth)
    nature.respond_to?(meth) || nurture.respond_to?(meth) || super
  end


  def names; [nature, nurture].map(&:name); end
  def name; Phrase.new names; end

  def diagonal?; [0,3].include? index; end

  def index; ALL.index(self); end
  def description; Adjective.new(%w{lazy driven sensitive stressed}[index]); end
  def letter; description.first; end
  ALL.each{|s| define_singleton_method(s.letter) {s}}
end
