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

  def mbti; %w{T S N F}[@index]; end
  def adjective; %w{financial physical mental interpersonal}[@index]; end
  def description; adjective.capitalize; end
  def description_with_mbti; "#{description} (#{mbti})"; end

  def full; %w{rich fat smart emotional}[@index]; end
  def empty; %w{poor thin stupid stoic}[@index]; end

  def small; [27, 700, 300, 30][@index]; end # three
  def medium; [40, 1000, 500, 60][@index]; end # two
  def large; [80, 2000, 1000, 90][@index]; end  # one
  def unit; %w{dollar calorie piece minute}[@index]; end
  def chunk; %w{check meal puzzle story}[@index]; end
  def chunks; chunk.pluralize; end

  def get; %w{earn eat analyze hear}[@index]; end
  def use; %w{spend do synthesize tell}[@index]; end

  def small_resource; "#{small}-#{unit} #{chunk}"; end
  def medium_resource; "#{medium}-#{unit} #{chunk}"; end
  def large_resource; "#{large}-#{unit} #{chunk}"; end

  def small_resources; "#{small}-#{unit} #{chunks}"; end
  def medium_resources; "#{medium}-#{unit} #{chunks}"; end
  def large_resources; "#{large}-#{unit} #{chunks}"; end

  def manic; "#{get} one #{large_resource} and #{use} three #{large_resources}"; end
  def hypomanic; "#{get} one #{large_resources} and #{use} three #{medium_resources}"; end
  def high; "#{get} one #{large_resource} and #{use} three #{small_resources}"; end

  def increasing; "#{get} two #{large_resources} and #{use} two #{medium_resources}"; end
  def average; "#{get} two #{medium_resources} and #{use} two #{medium_resources}"; end
  def decreasing; "#{get} two #{medium_resources} and #{use} two #{large_resources}"; end

  def low; "#{get} three #{small_resources} and #{use} one #{large_resource}"; end
  def hypodepressed; "#{get} three #{small_resources} and #{use} one #{medium_resource}"; end
  def depressed; "#{get} three #{small_resources} and #{use} one #{small_resource}"; end

  def generic_resources; %w{rewards things facts stories}[@index]; end
  def act(modifier=""); [get, modifier, generic_resources].join(" ").squish; end
  def react(modifier=""); [use, modifier, generic_resources].join(" ").squish; end

end
