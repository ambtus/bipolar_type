class Attitude < Indexable

  ########
  IDENTIFIERS = %w{ep ej ip ij }
  def self.paths; IDENTIFIERS; end
  ALL = IDENTIFIERS.collect{|letter| self.new letter}
  def self.all; self::ALL; end
  all.each { |i| define_singleton_method(i.path) {all[IDENTIFIERS.index i.string]} }
  ########

  def +(realm)
    subtypes.find{|s| s.realm == realm} || Subtype.new([realm, self])
  end

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end

end
