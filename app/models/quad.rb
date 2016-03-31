class Quad < Phrase

  def self.my_path; "s-n-f-t"; end
  def self.first; Quad.send my_path; end

  def initialize(string)
    @path = string
    if Attitude.paths.include? (string.split("-").first)
      @attitudes = string.split("-").collect{|a| Attitude.send(a)}
      @attitudes.check_constraints Attitude, 4, 4
      @realms = Realm.all
      super(@realms)
    else
      @realms = string.split("-").collect{|a| Realm.send(a)}
      @realms.check_constraints Realm, 4, 4
      @attitudes = Attitude.all
      super(@realms)
    end
  end
  attr_reader :realms, :path, :attitudes

  def subtypes; @realms.add(@attitudes); end

  %w{first second third fourth last}.each  do |meth|
    define_method(meth) {subtypes.send(meth)}
  end

  def self.paths; Realm.all.permutation(4).collect{|array| array.join("-")}; end
  ALL = self.paths.collect{|path| self.new(path)}
  def self.all; ALL; end
  ALL.each {|quad| define_singleton_method(quad.path) {quad} }

  def discover_without(subtype)
    raise unless subtypes.include? subtype
    "Q4_#{subtypes.without(subtype).map(&:path).join}"
  end

  def names; subtypes.values_at(0,1,3,2).map(&:name); end
  def inspect; names.join("•"); end
  def name; inspect; end

end
