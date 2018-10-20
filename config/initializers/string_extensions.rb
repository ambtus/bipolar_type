# Restart required even in development mode when you modify this file.

%w{second third fourth chip to_word words to_phrase is_mbti? inf s ly}.each do |meth|
 raise "#{meth} is already defined in String class" if String.method_defined?(meth)
end

class String

  def chip; self[1..-1]; end
  def second; chars.second; end
  def third; chars.third; end
  def fourth; chars.fourth; end
  def to_word; Word.new self ; end
  def words; split.map(&:to_word); end
  def to_phrase; Phrase.new words; end
  def to_word_or_phrase; words.size > 1 ? to_phrase : words.first; end

  MBTIS = %w{ISTP ISFP INTP INFP
             ISTJ ISFJ INTJ INFJ
             ESTP ESFP ENTP ENFP
             ESTJ ESFJ ENTJ ENFJ}
  def is_mbti?; MBTIS.include? self; end

  def s
    return "people" if self=="person"
    return "speaches" if self=="speach"
    self.sub(/e?y$/, "ie") + "s"
  end
  def ed
    return "felt" if self=="feel"
    return "bought" if self=="buy"
    return "told" if self=="tell"
    return "spent" if self=="spend"
    return "made" if self=="make"
    return "heard" if self=="hear"
    return "did" if self=="do"
    self.sub(/e$/, "") + "ed"
  end
  SAME = %w{solve watch learn taste hear make earn spend tell buy collect feel influence}
  def is_same?; SAME.include? self; end
  def en
    return "said" if self =="talk"
    return "said" if self=="tell"
    return "heard" if self=="listen"
    return "done" if self=="do"
    return self.ed if self.is_same?
    self.sub(/e$/, "") + "en";
  end
  def ly; self + "ly"; end
  def ing
    return "lying" if self=="lie"
    return "listening" if self=="listen"
    if self.match(" ")
      first, second = self.split(' ', 2)
      [first.ing, second].join(" ")
    elsif self.match("/")
      first, second = self.split('/', 2)
      [first.ing, second.ing].join("/")
    else
      self.sub(/([^aeiou])([aeiou])([bpntg])$/, '\1\2\3\3').sub(/([^e])e$/, '\1') + "ing"
    end
  end

end
