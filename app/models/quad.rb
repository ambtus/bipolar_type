class Quad < Phrase

  def self.my_path; "s-n-t-f"; end
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

  def ordered_subtypes; subtypes.values_at(0,1,3,2); end

  def self.paths; Realm.all.permutation(4).collect{|array| array.join("-")}; end
  ALL = self.paths.collect{|path| self.new(path)}
  def self.all; ALL; end
  ALL.each {|quad| define_singleton_method(quad.path) {quad} }

  def discover_without(subtype)
    raise unless subtypes.include? subtype
    "Q4_#{subtypes.without(subtype).map(&:path).join}"
  end

  def pairs; [[first, third], [second, fourth]]; end
  def paired(subtype); (pairs.find{|p| p.include? subtype} - [subtype]).first; end

  def inspect; subtypes.join("•"); end
  def name; inspect; end

  %w{first second third fourth last}.each  do |meth|
    define_method(meth) {realms.send(meth)}
  end
  def mbti
    if "E#{first.mbti_order(second)}P".is_mbti?
      "E#{first.mbti_order(second)}P/I#{third.mbti_order(fourth)}J"
    elsif "I#{first.mbti_order(fourth)}P".is_mbti?
      "I#{first.mbti_order(fourth)}P/E#{second.mbti_order(third)}J"
    end
  end

  def self.by_mbti; ALL.sort_by(&:mbti); end

  def letters; realms.map(&:letter); end
end
