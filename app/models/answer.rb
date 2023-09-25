class Answer

  def self.first_path; "Q1"; end
  def self.first; Answer.new(first_path); end

  def initialize(string)
    @question,@realm_paths = string.split(":")
    @realm_paths = @realm_paths || ""
  end
  attr_reader :question, :realm_paths

  def number; @question.last.to_i ; end
  def index; number - 1; end
  def finished?; number > 4; end

  def realms; @realm_paths.scan(/./).collect{|x| Realm.send(x)}; end
  def generics; GenericBehavior.all.reverse[0..index]; end
  def behaviors; realms.add(generics); end

  def generic_behavior; generics[index]; end

  def css(behavior)
    return "chosen" if behaviors.include?(behavior)
    return "constrained" if realms.include?(behavior.realm)
    return "constrained" unless behavior.generic_behavior.index == 3 - index
    return "free"
  end

  def free?(behavior); css(behavior) == "free"; end

  def paths(behavior); [realm_paths, behavior.realm.symbol].join; end
  def next(behavior); "#{question.next}:#{paths(behavior)}"; end

  def type_path; finished? && realms.map(&:symbol).reverse.join; end


end
