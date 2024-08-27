class Response

  NAMES = %w{ Use Get}

  def initialize(name); @name = name; end
  attr_reader :name
  alias inspect :name
  def letter; name.first; end
  alias path :letter

  def index; NAMES.index @name; end
  def <=>(other); index <=> other.index; end
  def mbti; %w{ E I}[index]; end
  alias display :mbti

  def symbolic_name; [display.colon, name].to_phrase; end

  ALL = NAMES.collect {|name| self.new name}
  def self.all; ALL; end

  def flip; ALL.without(self).first; end
  alias opposite :flip
  # no-op to allow mapping
  def flop; self; end

  def episode; %w{ mania depression}[index]; end
  def bipolar; %w{ manic depressed}[index]; end
  def ready; %w{ able willing}[index]; end
  def trigger; %w{ danger exhaustion}[index]; end
  def drugs; %w{ stimulants sedatives}[index]; end
end
