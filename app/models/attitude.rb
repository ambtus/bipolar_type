class Attitude < Indexable

  MBTI = %w{P E I J}
  ADJECTIVE = %w{obese insensitive sensitive anorexic}

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

  def name; Phrase.new [adjective.capitalize, mbti.parenthesize]; end

  def extreme?; [0,3].include? index; end

  def mbti; choose Word, MBTI; end

  def adjective; choose Adjective, ADJECTIVE; end
end
