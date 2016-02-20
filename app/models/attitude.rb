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

  def loss?; index < 2; end
  def more?; index.even?; end
  def rational?; [0,3].include? index; end

  def modifier; more? ? "more" : "less"; end

  def easy; loss? ? "lose" : "gain"; end
  def hard; loss? ? "gain" : "lose"; end

  def result; loss? ? "loss" : "accumulation"; end

end
