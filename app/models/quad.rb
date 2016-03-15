class Quad < Phrase

  def self.my_path; "fstn"; end
  def self.first; Quad.send my_path; end

  def initialize(string)
    @path = string
    if Attitude.paths.include? (string.first)
      @attitudes = string.scan(/./).collect{|a| Attitude.send(a)}
      @attitudes.check_constraints Attitude, 4, 4
      @realms = Realm.all
      super(@realms)
    else
      @realms = string.scan(/./).collect{|a| Realm.send(a)}
      @realms.check_constraints Realm, 4, 4
      @attitudes = Attitude.all
      super(@realms)
    end
  end
  attr_reader :realms, :path, :attitudes

  def subtypes; @realms.add(@attitudes); end

  def self.paths; Realm.all.permutation(4).map(&:join); end
  ALL = self.paths.collect{|path| self.new(path)}
  def self.all; ALL; end
  ALL.each {|quad| define_singleton_method(quad.path) {quad} }

  def discover_without(subtype)
    raise unless subtypes.include? subtype
    "Q4_#{subtypes.without(subtype).map(&:path).join}"
  end

  def names; subtypes; end
  def inspect; names.join("•"); end
  def name; inspect; end

  def problem; "I am both #{subtypes.second.fat.er} and #{subtypes.third.thin.er} than I want to be."; end

end
