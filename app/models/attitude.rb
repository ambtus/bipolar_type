class Attitude < Indexable

  ########
  LETTERS = %w{P J E I}
  ALL = LETTERS.collect{|letter| self.new letter}
  def path; super.downcase; end
  def self.paths; all.map(&:path); end
  all.each do |realm|
    define_singleton_method(realm.path) {all[LETTERS.index realm.string]}
  end
  ########

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end

  def result; choose Adjective, %w{fat strong energetic thin}; end
  def name; Phrase.new [result.capitalize, parenthesize]; end

  def ordered_words(realm); index < 2 ? [realm, self] : [self, realm]; end

  def ordered_behaviors(binge, futz, burst, graze)
    case string
    when "P"
      [binge,futz,graze,burst]
    when "E"
      [futz,binge,burst,graze]
    when "J"
      [burst,graze,futz,binge]
    when "I"
      [graze,burst,binge,futz]
    end
  end


end
