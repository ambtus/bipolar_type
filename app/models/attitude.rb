class Attitude < Indexable

  ########
  IDENTIFIERS = %w{a b c d}
  def self.paths; IDENTIFIERS; end
  ALL = IDENTIFIERS.collect{|letter| self.new letter}
  def self.all; self::ALL; end
  all.each { |i| define_singleton_method(i.path) {all[IDENTIFIERS.index i.string]} }
  ########

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end

end
