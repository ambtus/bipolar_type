class Attitude < Indexable

  ########
  LETTERS = %w{EP EJ IJ IP}
  ALL = LETTERS.collect{|letter| self.new letter}
  all.each { |a| define_singleton_method(a.path) {all[LETTERS.index a.string]} }
  ########

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end

  def adjective; choose Adjective, %w{fat thin hefty skinny}; end
  def name; Phrase.new [adjective.capitalize, parenthesize]; end
  #def name; adjective.capitalize; end

  def sensitivity_amount; choose Adjective, %w{least less more most}; end
  def sensitivity; Phrase.new [sensitivity_amount, "sensitive"]; end

  def mania; choose Adjective, %w{wonderful mixed mixed horrible}; end
  def depression; choose Adjective, %w{horrible mixed mixed wonderful}; end

  def insensitive?; [0, 1].include? index; end
  def consumer?; [0, 2].include? index; end

  def how_much_of; choose Phrase, [%w{even more of}, %w{most of}, %w{a lot of}, %w{even more of}]; end
end
