class Attitude < Concept

  ########
  ACRONYMS = %w{ep ej ij ip}
  ALL = ACRONYMS.collect {|letter| self.new letter}
  ACRONYMS.each do |letter|
    define_singleton_method(letter) {ALL[ACRONYMS.index(letter)]}
  end
  ########

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end
  def +(realm); subtypes.find{|s| s.realm == realm}; end

  def mbti; path.upcase; end
  def first; path.first; end
  def second; path.second; end

  POSITIVES = %w{appreciative liberal conservative fastidious}
  def positive; POSITIVES[index]; end

  NEGATIVES = %w{greedy hyperactive lazy picky}
  def negative; NEGATIVES[index]; end

  EPISODE = %w{binge mania depression purge}
  def episode; EPISODE[index]; end

  def progression; [positive, negative, episode].join(" => "); end

end
