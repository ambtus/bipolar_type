class Answer

  def initialize(string)
    @question,@letters = string.split("_")
    @letters = "" unless @letters
  end
  attr_reader :question

  def number; @question.last.to_i ; end

  def subtypes; @letters.scan(/.../).collect{|x| Subtype.find(x)}; end

  def attitude_realms; subtypes.map(&:attitude_realm); end

  def choices
    Preference.all[number - 1].subtypes.collect do |subtype|
      chosen?(subtype) ? chosen(subtype) : subtype
    end
  end

  def chosen?(subtype); attitude_realms.include?(subtype.attitude_realm); end
  def chosen(subtype); subtypes.select{|s| s.attitude_realm == subtype.attitude_realm}.first; end

  def free?(subtype); ! subtype.wing?(subtypes); end

  def next(letters);
    subtype =  Subtype.find(letters)
    if free?(subtype)
      @question.next + "_" + @letters + letters
    else
      replaced = subtypes.select do |current|
        subtype.wing?([current])
      end
      new_subtypes = subtypes - replaced
      "Q" + new_subtypes.size.to_s.next.next + "_" + new_subtypes.map(&:letters).join + letters
    end
  end

  def type_path(last); (@letters + last); end
end
