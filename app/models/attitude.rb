class Attitude
  LETTERS = %w{ep ej ip ij}

  def initialize(letter)
    raise "#{letter} isn't an Attitude" unless LETTERS.include?(letter)
    @index = LETTERS.index(letter)
    @path = letter
  end
  attr_reader :index, :path

  ATTITUDES = LETTERS.collect{|letter| Attitude.new(letter)}
  def self.all; ATTITUDES; end
  def self.find(letter); ATTITUDES[LETTERS.index(letter)]; end

  def +(realm); Subtype.find(realm.path + self.path); end
  def subtypes; Realm.all.add(self); end

  LETTERS.each {|r| define_singleton_method(r) {find(r)}}

  def nature; index < 2 ? "extroverted" : "introverted"; end

  def opposite_path; LETTERS.reverse[@index]; end
  def opposite; Attitude.find(opposite_path); end

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

  def result; %w{overfull underfull overfull underfull}[@index]; end

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

  def ip_only
    return nil unless path == "ip"
    "the resources are toxic"
  end
  def ej_only
    return nil unless path == "ej"
    "I create my own resources"
  end

  def only; [ip_only,ej_only].flatten.compact.first; end

  def i_am; "I am too #{result}"; end
  def i_should; "I should #{conscious}"; end

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

end
