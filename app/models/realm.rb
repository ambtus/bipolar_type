class Realm
  LETTERS = %w{a b c d}

  def initialize(string)
    @index = LETTERS.index(string)
    raise "#{string} isn't a Realm" unless @index
    @letter = string
  end
  attr_reader :letter

  REALMS = LETTERS.collect{|choice| Realm.new(choice)}
  def self.all; REALMS; end
  def self.find(letter); REALMS[LETTERS.index(letter)]; end

  def subtypes; Subtype.all.select{|s| s.realm == self}; end

  def neuro; %w{dopamine serotonin GABA oxytocin}[@index]; end
  def neuro_up; neuro.slice(0).upcase + neuro.slice(1..-1); end

  def adjective; %w{financial physical mental interpersonal}[@index]; end
  def description; adjective.capitalize; end
  def mbti; %w{T S N F}[@index]; end
  def function; mbti.gsub(/[a-z]/, ""); end
  def with_mbti; "(#{mbti})"; end
  def description_with_mbti; [description, with_mbti].join(" "); end

  def get; %w{earn eat analyze smile}[@index]; end
  def use; %w{spend exercise synthesize frown}[@index]; end

  def get_or_use;  [get, use].join(" or "); end
  def getting_or_using;  [get, use].map(&:ing).join(" or "); end


  def full; %w{rich fat pedantic popular}[@index]; end
  def empty; %w{poor thin dogmatic lonely}[@index]; end

  def full_or_empty; [full, empty].join(" or "); end

  def balance; ["balance", full_or_empty, "by", getting_or_using].join(" "); end

end
