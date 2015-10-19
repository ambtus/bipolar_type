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

  def result
    case path
    when "ep"
      "too much energy"
    when "ej"
      "just enough strength"
    when "ij"
      "just enough energy"
    when "ip"
      "too little strength"
    end
  end

  def name; result.split.map(&:capitalize).join; end

  def relax
    case path
    when "ep"
      "output more"
    when "ej"
      "input more"
    when "ij"
      "output less"
    when "ip"
      "input less"
    end
  end

  def try_harder
    case path
    when "ep"
      "consume less energy"
    when "ej"
      "consume less strength"
    when "ij"
      "consume more strength"
    when "ip"
      "consume more energy"
    end
  end

  def method_missing(method, *args, &block)
    if Realm.generic.respond_to? method
      Realm.generic.send(method, *args, &block)
   else
     super
   end
  end

end
