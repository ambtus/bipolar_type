class Preference < Indexable

  ########
  LETTERS = %w{e i}
  ALL = LETTERS.collect{|letter| self.new letter}
  LETTERS.each{|l| define_singleton_method(l) {all[LETTERS.index l]}}
  ########

  def happy_time
    if letter == "i"
      Phrase.early
    elsif letter == "e"
       Phrase.late
    else
      raise "letters are defined wrong in preference.rb"
    end
  end

end
