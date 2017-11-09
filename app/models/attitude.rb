class Attitude < Concept

  ########
  ACRONYMS = %w{ep ej ip ij}
  ALL = ACRONYMS.collect {|letter| self.new letter}
  ACRONYMS.each do |letter|
    define_singleton_method(letter) {ALL[ACRONYMS.index(letter)]}
  end
  ########

  POSITIVES = %w{appreciative liberal discriminating conservative}
  def positive; POSITIVES[index]; end
  def name; positive.capitalize; end

  NEGATIVES = %w{greedy hyperactive ungrateful lazy}
  def negative; NEGATIVES[index]; end

  EPISODE = %w{binging manic purging depressed}
  def episode; EPISODE[index]; end

  def get_or_use; index.even? ? "get" : "use"; end
  def less_or_more; index < 2 ? "less" : "more"; end

  def goal; [get_or_use, less_or_more, "energy"].join(" "); end

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end
  def +(realm); subtypes.find{|s| s.realm == realm}; end

  def mbti; path.upcase; end
  def first; path.first; end
  def second; path.second; end

end
