class Attitude
  LETTERS = %w{ep ej ij ip}

  def initialize(letter)
    raise "#{letter} isn't an Attitude" unless LETTERS.include?(letter)
    @index = LETTERS.index(letter)
    @path = letter
  end
  attr_reader :index, :path

  ATTITUDES = LETTERS.collect{|letter| Attitude.new(letter)}
  def self.all; ATTITUDES; end
  def self.find(letter); ATTITUDES[LETTERS.index(letter)]; end

  def +(realm); Subtype.find(self.path + realm.path); end
  def subtypes; Realm.all.add(self); end

  LETTERS.each {|r| define_singleton_method(r) {find(r)}}

  def short
    case path
    when "ep"
      "willing inputter"
    when "ej"
      "willing outputter"
     when "ij"
      "unwilling outputter"
     when "ip"
      "unwilling inputter"
    end
  end

  def name; short.titleize.squash; end

  def manic_advice
    case path
    when "ep"
      "keep outputting"
    when "ej"
      "turn down the stimulus"
     when "ij"
      "stop outputting"
     when "ip"
      "turn off the stimulus"
    end
  end

def depressed_advice
    case path
    when "ep"
      "start outputting"
    when "ej"
      "turn up the stimulus"
     when "ij"
      "start outputting"
     when "ip"
      "turn on the stimulus"
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
