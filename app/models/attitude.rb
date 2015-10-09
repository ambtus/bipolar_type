class Attitude
  LETTERS = %w{ep ej ip ij}

  def initialize(letter)
    raise "#{letter} isn't an Attitude" unless LETTERS.include?(letter)
    @index = LETTERS.index(letter)
    @path = letter
  end
  attr_reader :index, :path
  def mbti; path.upcase; end

  ATTITUDES = LETTERS.collect{|letter| Attitude.new(letter)}
  def self.all; ATTITUDES; end
  def self.find(letter); ATTITUDES[LETTERS.index(letter)]; end

  def +(realm); Subtype.find(realm.path + self.path); end
  def subtypes; Realm.all.add(self); end

  LETTERS.each {|r| define_singleton_method(r) {find(r)}}

  Realm.all.each {|r| define_method(r.path) {[self,r].to_mbti}}

  def nature; index < 2 ? "extroverted" : "introverted"; end

  def subconscious
    case path
    when "ep"
      "produce less"
    when "ej"
      "consume less"
    when "ip"
      "consume more"
    when "ij"
      "produce more"
    end
  end

  def result; %w{fat thin fat thin}[@index]; end

  def conscious
    case path
    when "ep"
      "consume less"
    when "ej"
      "produce less"
    when "ip"
      "produce more"
    when "ij"
      "consume more"
    end
  end

  def name; %w{Top Dom Sub Bottom}[@index]; end

  def description; ["I am too #{result}","I should #{conscious}!"].join('<br />').html_safe; end

  def role
    case path
    when "ej"
      "stop consuming whenever anyone or anything wants you to stop consuming"
    when "ep"
      "stop producing whenever anyone or anything wants you to stop producing"
    when "ip"
      "keep consuming whenever anyone or anything wants you to keep consuming"
    when "ij"
      "keep producing whenever anyone or anything wants you to keep producing"
    end
  end


  def advice; %w{run binge fast sit}[@index]; end
  def method_missing(method, *args, &block)
    if method.to_s =~ /^(.*)_with_mbti$/
      [self.send($1, *args, &block).gsub('<br />', " & "), mbti.parenthetical].join(" ")
    else
      super
    end
  end

end
