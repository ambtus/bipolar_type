class Nurture < Indexable

  ########
  IDENTIFIERS = %w{ p j }
  def self.paths; IDENTIFIERS; end
  ALL = IDENTIFIERS.collect{|letter| self.new letter}
  def self.all; self::ALL; end
  all.each { |i| define_singleton_method(i.path) {all[IDENTIFIERS.index i.string]} }
  ########

  def attitudes; Attitude.all.select{|s| s.nurture == self}; end

  def left?; index.even?; end

  def description; choose Adjective, %w{consumer producer}; end
  def name; description.capitalize; end

end
