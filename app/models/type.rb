class Type

  def initialize(string)
    @path = string
    @basic = string.first
    @subtypes = string[1..-1].scan(/../).collect{|x| Subtype.find(x)}
  end

  attr_reader :path, :subtypes, :basic

  def other; @basic == "i" ? "e" : "i"; end

  def mbtis; subtypes.collect{|s| s.mbti(s.basic == basic)}.join("-"); end
  def realms; @subtypes.map(&:realm); end

  def spring; realms.first; end
  def summer; realms.second; end
  def autumn; realms.third; end
  def winter; realms.fourth; end

end
