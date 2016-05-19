class Tendency < Indexable

  NOUNS = %w{consumer producer}

  ########
  IDENTIFIERS = NOUNS.map(&:first)
  def self.paths; IDENTIFIERS; end
  ALL = IDENTIFIERS.collect{|letter| self.new letter}
  def self.all; self::ALL; end
  all.each { |i| define_singleton_method(i.path) {all[IDENTIFIERS.index i.string]} }
  ########

  def attitudes; Attitude.all.select{|s| s.tendency == self}; end

  def left?; index.even?; end

  def noun; choose Noun, NOUNS; end
  def description; noun; end
  def name; description.capitalize; end

end
