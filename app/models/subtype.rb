class Subtype
  LETTERS = Realm::LETTERS.multiply(Attitude::LETTERS).flatten

  def initialize(letters)
    raise "#{letters} isn't a Subtype" unless LETTERS.include?(letters)
    @index = LETTERS.index(letters)
    @path = letters
  end
  attr_reader :path
  def mbti; path.upcase.mbti_order; end

  SUBTYPES = LETTERS.collect{|letters| Subtype.new(letters)}
  def self.all; SUBTYPES; end
  def self.find(letters); SUBTYPES[LETTERS.index(letters)]; end

  def realm; Realm.find(path[0,1]); end
  def attitude; Attitude.find(path[1,2]); end

  def quads; Quad.all.select{|q| q.subtypes.include?(self)}; end

  def long_name; [realm.physical.ly, attitude.fat].join(" "); end

  def name; realm.send(attitude.fat).titleize; end

  def result
    case attitude.path
    when "ep"
      "plenty of #{realm.fat_deposits}"
    when "ej"
      "plenty of #{realm.muscles}"
    when "ip"
      "very #{realm.muscles.few}"
    when "ij"
      "very #{realm.fat_deposits.few}"
    end
  end

  def long
     attitude.description.gsub('consuming', "#{realm.eat1.ing}").gsub('producing', "#{realm.produce.ing}")
 end

  def description; [long, result].join('<br />').html_safe; end

  def method_missing(method, *args, &block)
    if method.to_s =~ /^(.*)_with_mbti$/
      [self.send($1, *args, &block).gsub('<br />', " & "), mbti.parenthetical].join(" ")
    else
      realm.send(method, *args, &block)
    end
  end

end
