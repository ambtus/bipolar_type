class Attitude < Indexable

  ########
  IDENTIFIERS = %w{ obese fat anorexic skinny }
  def self.paths; IDENTIFIERS; end
  ALL = IDENTIFIERS.collect{|letter| self.new letter}
  all.each { |a| define_singleton_method(a.path) {all[IDENTIFIERS.index a.string]} }
  ########

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end

  def identifier; choose Noun, IDENTIFIERS; end
  def name; identifier.titleize; end

  def top?; index < 2; end
  def left?; index.even?; end
  def diagonal?; [0,3].include? index; end

  def have; top? ? "more" : "fewer"; end

  def want; left? ? "fewer" : "more"; end

  %w{first second third fourth}.each do |meth|
    define_method(meth + "?") {ALL.send(meth) == self}
  end

end
