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

  def opposite; self.class.send(%w{ tortoise binger grazer hare }[index]); end
  def manic; self.class.send(%w{ grazer hare hare grazer }[index]); end
  def depressed; self.class.send(%w{binger tortoise tortoise binger}[index]); end

end
