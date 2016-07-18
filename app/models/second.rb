class Second < Concept

  NAMES = %w{consumer producer}

  ########
  ACRONYMS = NAMES.map(&:first)
  ALL = ACRONYMS.collect {|letter| self.new letter}
  ACRONYMS.each {|letter| define_singleton_method(letter) { ALL[ACRONYMS.index(letter)] } }
  ########

  def attitudes; Attitude.all.select{|s| s.second == self}; end
  def +(first); attitudes.find{|s| s.second == second}; end

  def description; NAMES[index]; end
  def name; description.capitalize; end

  def location; %w{left right}[index]; end
  def loc; location; end
end
