class First < Concept

  NAMES = %w{insensitive sensitive}

  ########
  ACRONYMS = NAMES.map(&:first)
  ALL = ACRONYMS.collect {|letter| self.new letter}
  ACRONYMS.each {|letter| define_singleton_method(letter) { ALL[ACRONYMS.index(letter)] } }
  ########

  def attitudes; Attitude.all.select{|s| s.first == self}; end
  def +(second); attitudes.find{|s| s.second == second}; end

  def description; NAMES[index]; end
  def name; "#{description.capitalize} (#{symbol})"; end

  def location; %w{top bottom}[index]; end

end
