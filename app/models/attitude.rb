class Attitude < Indexable

  ########
  IDENTIFIERS =  %w{first second third fourth}
  def self.paths; IDENTIFIERS; end
  ALL = IDENTIFIERS.collect{|letter| self.new letter}
  all.each { |a| define_singleton_method(a.path) {all[IDENTIFIERS.index a.string]} }
  ########

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end

  def identifier; choose Adjective, IDENTIFIERS; end
  def ordinal; IDENTIFIERS[index]; end

end
