class Attitude < Indexable

  MBTI = %w{P E I J}
  ADJECTIVE = %w{fat strong weak thin}

  ########
  LETTERS = MBTI.map(&:downcase)
  def self.paths; LETTERS; end
  ALL = LETTERS.collect{|letter| self.new letter}
  def self.all; ALL; end
  LETTERS.each do |letter|
    define_singleton_method(letter) { ALL[LETTERS.index(letter)] }
  end
  ########

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end
  def +(realm); subtypes.find{|s| s.realm == realm} || Subtype.new([realm, self]); end
  def quad; Quad.new Array.new(4, self).map(&:path).join; end

  def mbti; choose Word, MBTI; end
  def after?; %w{P J}.include? mbti.string; end

  def adjective; choose Adjective, ADJECTIVE; end
  def name; Phrase.new [adjective.capitalize, mbti.parenthesize]; end

end
