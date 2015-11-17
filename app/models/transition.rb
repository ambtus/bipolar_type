class Transition < Indexable

  ########
  LETTERS = %w{e i}
  ALL = LETTERS.collect{|letter| self.new letter}
  LETTERS.each{|l| define_singleton_method(l) {all[LETTERS.index l]}}
  ########

  def signal_location; choose String, %w{external internal}; end

end
