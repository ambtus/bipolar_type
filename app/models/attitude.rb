class Attitude < Concept

  ########
  ACRONYMS = %w{ep ej ip ij}
  ALL = ACRONYMS.collect {|letter| self.new letter}
  ACRONYMS.each do |letter|
    define_singleton_method(letter) {ALL[ACRONYMS.index(letter)]}
  end
  %w{first second third fourth}.each_with_index do |ordinal, index|
    define_singleton_method(ordinal) {ALL[index]}
  end
  ########

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end
  def +(realm); subtypes.find{|s| s.realm == realm}; end

  def mbti; path.upcase; end
  def first; path.first; end
  def second; path.second; end

  POSITIVES = %w{appreciative liberal humble conservative}
  def positive; POSITIVES[index]; end

  NEGATIVES = %w{greedy hyperactive ungrateful lazy}
  def negative; NEGATIVES[index]; end

  PROBLEMS = %w{binge mania purge depression}
  def problem; PROBLEMS[index]; end

  def progression; [positive, negative, problem].join(" => "); end

  def name; problem.capitalize; end

end
