class Sensitivity < Indexable

  ########
  LETTERS = %w{E I}
  ALL = LETTERS.collect{|letter| self.new letter}
  LETTERS.each{|l| define_singleton_method(l.downcase) {all[LETTERS.index l]}}
  def path; string.downcase; end
  ########

  def priority(array); index.odd? ? array : array.reverse; end

  def frequency; index.odd? ? "sometimes" : "usually"; end
end
