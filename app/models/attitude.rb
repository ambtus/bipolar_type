class Attitude < Indexable

  ########
  IDENTIFIERS = %w{ hare grazer binger tortoise }
  def self.paths; IDENTIFIERS; end
  ALL = IDENTIFIERS.collect{|letter| self.new letter}
  all.each { |a| define_singleton_method(a.path) {all[IDENTIFIERS.index a.string]} }
  ########

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end

  def identifier; choose Noun, IDENTIFIERS; end
  def name; identifier.titleize; end

  def top?; index < 2; end
  def left?; index.even?; end
  def backslash?; [0,3].include? index; end

  def easy; top? ? "lose" : "gain"; end
  def hard; top? ? "gain" : "lose"; end

end
