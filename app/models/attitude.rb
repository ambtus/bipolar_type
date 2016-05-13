class Attitude < Indexable

  ########
  IDENTIFIERS = %w{ tl tr bl br }
  def self.paths; IDENTIFIERS; end
  ALL = IDENTIFIERS.collect{|letter| self.new letter}
  def self.all; self::ALL; end
  all.each { |i| define_singleton_method(i.path) {all[IDENTIFIERS.index i.string]} }
  ########

  def +(realm); subtypes.find{|s| s.realm == realm} || Subtype.new([realm, self]); end
  def quad; Quad.new Array.new(4, path).join; end
  def subtypes; Subtype.all.select{|s| s.attitude == self}; end
  Realm.all.each {|r| define_method(a.path) {self + r}}
  def generic_subtype; Subtype.new [Realm.generic, self]; end

  def top?; path.first == "t"; end
  def left?; path.second == "l"; end
  def diagonal?; [0,3].include? index; end

  def description; choose Adjective, %w{lazy driven sensitive aversive}; end
  def name; description.capitalize; end
  def letter; description.first; end

  def drugs; top? ? "stimulants" : "sedatives"; end

end
