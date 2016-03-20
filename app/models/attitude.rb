class Attitude < Indexable

  ########
  IDENTIFIERS = %w{ ep ej ij ip }
  def self.paths; IDENTIFIERS; end
  ALL = IDENTIFIERS.collect{|letter| self.new letter}
  def self.all; self::ALL; end
  all.each { |i| define_singleton_method(i.path) {all[IDENTIFIERS.index i.string]} }
  ########

  def +(realm); subtypes.find{|s| s.realm == realm} || Subtype.new([realm, self]); end
  def quad; Quad.new Array.new(4, path).join("-"); end
  def subtypes; Subtype.all.select{|s| s.attitude == self}; end
  Realm.all.each {|r| define_method(a.path) {self + r}}
  def generic_subtype; Subtype.new [Realm.generic, self]; end

  def insensitive?; index < 2; end
  def provider?; [1,2].include? index; end

  def description_adjective; Adjective.new(insensitive? ? "insensitive" : "sensitive"); end
  def description_noun; Noun.new(provider? ? "provider" : "consumer"); end
  def description; Phrase.new [description_adjective, description_noun]; end
  def name; description.titleize; end


end
