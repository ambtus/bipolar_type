class Type
  def self.my_path; Nature.my_path + "i"; end
  def self.first; Type.find(my_path); end

  LETTERS = Nature::LETTERS.product(Stability::LETTERS).map(&:join)

  def initialize(letters)
    raise "#{letters} isn't a Type" unless LETTERS.include?(letters)
    @index = LETTERS.index(letters)
    @path = letters
  end
  attr_reader :path

  TYPES = LETTERS.collect{|letters| Type.new(letters)}
  def self.all; TYPES; end
  def self.find(letters); TYPES[LETTERS.index(letters)]; end

  def nature; Nature.find(path[0,4]); end
  def stability; Stability.find(path.last); end

  def name; [stability, nature].map(&:name).join(" "); end

  def trumps; stability.trumps; end

  def trump_subtypes;
    case path.last
    when "i"
      [
      subtypes.find{|s| s.attitude.path=="ip"},
      subtypes.find{|s| s.attitude.path=="ep"},
      subtypes.find{|s| s.attitude.path=="ij"},
      subtypes.find{|s| s.attitude.path=="ej"},
      ]
    when "j"
      [
      subtypes.find{|s| s.attitude.path=="ej"},
      subtypes.find{|s| s.attitude.path=="ij"},
      subtypes.find{|s| s.attitude.path=="ep"},
      subtypes.find{|s| s.attitude.path=="ip"},
      ]
    end
  end

  def trump_additions;
    case path.last
    when "i"
      [
      subtypes.find{|s| s.attitude.path=="ij"}.behaviors.find{|b| b.qua.path=="i"},
      subtypes.find{|s| s.attitude.path=="ip"}.behaviors.find{|b| b.qua.path=="p"},
      subtypes.find{|s| s.attitude.path=="ej"}.behaviors.find{|b| b.qua.path=="j"},
      subtypes.find{|s| s.attitude.path=="ep"}.behaviors.find{|b| b.qua.path=="e"},
      ]
    when "j"
      [
      subtypes.find{|s| s.attitude.path=="ij"}.behaviors.find{|b| b.qua.path=="j"},
      subtypes.find{|s| s.attitude.path=="ip"}.behaviors.find{|b| b.qua.path=="i"},
      subtypes.find{|s| s.attitude.path=="ej"}.behaviors.find{|b| b.qua.path=="e"},
      subtypes.find{|s| s.attitude.path=="ep"}.behaviors.find{|b| b.qua.path=="p"},
      ]
    end
  end

  def mbtis
    trump_subtypes.collect.each_with_index do |subtypes, index|
      (subtypes.mbti + trump_additions[index].mbti).mbti_order
    end
  end

  def method_missing(method, *args, &block)
    if method.to_s =~ /^(.*)_with_mbti$/
      [self.send($1, *args, &block), mbti.parenthetical].join(" ")
    else
      nature.send(method, *args, &block)
    end
  end
end
