class Attitude < Indexable

  ########
  LETTERS = %w{EP IP IJ EJ}
  ALL = LETTERS.collect{|letter| self.new letter}
  all.each { |a| define_singleton_method(a.path) {all[LETTERS.index a.string]} }
  ########

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end
  def generic_subtype; Subtype.new [Realm.generic, self]; end

  def domain; choose Verb, %w{consume produce effect provide}; end
  def domainer; domain.er; end
  def name; Phrase.new [domainer.capitalize, parenthesize]; end

  def sensitivity_amount; choose Adjective, %w{least most more less}; end
  def sensitivity; Phrase.new [sensitivity_amount, "sensitive"]; end

  def mania; choose Adjective, %w{wonderful horrible mixed mixed}; end
  def depression; choose Adjective, %w{horrible wonderful mixed mixed}; end

  def insensitive?; [0, 3].include? index; end
  def consumer?; [0, 2].include? index; end

  def how_much_of; choose Phrase, [%w{even more of}, %w{even more of}, %w{a lot of}, %w{most of}]; end
end
