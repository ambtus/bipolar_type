class Attitude < Indexable

  ########
  IDENTIFIERS = %w{ic ip sc sp}
  def self.paths; IDENTIFIERS; end
  ALL = IDENTIFIERS.collect{|letter| self.new letter}
  all.each { |a| define_singleton_method(a.path) {all[IDENTIFIERS.index a.string]} }
  ########

  def insensitive?; index < 2; end
  def sensitivity;  insensitive? ? "insensitive" : "sensitive"; end
  def consumer?; index.even?; end
  def behavior;  consumer? ? "consumer" : "producer"; end

  def identifier; [sensitivity, behavior].join(" "); end
  def name; identifier.titleize; end

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end
  def generic_subtype; Subtype.new [Realm.generic, self]; end

  def affect; Verb.new(insensitive? ? "love" : "like"); end
  def action; Verb.new(consumer? ? "consume" : "produce"); end
  def preference; Phrase.new [affect, "to", action]; end

  def change; Verb.new(consumer? ? "gain" : "lose"); end
  def speed; Word.new(insensitive? ? "quickly" : "slowly"); end

  private
    def potential; Noun.new "potential"; end


end
