class Realm

  def initialize(mbti); @mbti = mbti; end
  attr_reader :mbti
  alias path :mbti
  alias inspect :mbti

  MBTIS = %w{S T F N X}
  def index; MBTIS.index @mbti; end


  ALL = MBTIS.collect {|mbti| self.new mbti}
  def self.all; ALL[0,4]; end
  def self.with_generic; ALL; end
  def self.each(&block);ALL[0,4].each(&block); end
  def self.generic; ALL.last; end
  def generic?; self.class.generic == self; end
  def display; generic? ? '' : @mbti; end

  NAMES = %w{Physical Financial Affective Mental Generic}
  def name; NAMES[index]; end
  def symbolic_name; [@mbti.colon, name].to_phrase; end

  ALL.each_with_index do |instance, index|
    %w{mbti name}.each do |thing|
      define_singleton_method(instance.send(thing)) {ALL[index]}
      define_singleton_method(instance.send(thing).downcase) {ALL[index]}
    end
  end

  def adjective; generic? ? '' : name.downcase; end
  def adverb; adjective.ly; end

  def energy;       %w{calories money       emotions   facts}[index]    || __method__.to_s.to_phrase; end
  def strengths;    %w{muscles  credit      language   theories}[index] || __method__.to_s.to_phrase; end

  def get;          %w{eat      earn        listen\ to look\ at}[index] || __method__.to_s.to_phrase; end
  def energizers;   %w{carbs    wages       music      details}[index]  || __method__.to_s.to_phrase; end
  def strengtheners;%w{protein  a\ salary   words      results}[index]  || __method__.to_s.to_phrase; end

  # method name must match Behavior send_name
  def burn_energy;  %w{run      pay\ cash   emote      decide}[index]   || __method__.to_s.to_phrase; end
  def use_strength; %w{clean    use\ credit verbalize  theorize}[index] || __method__.to_s.to_phrase; end
  def get_energy;      [get, energizers].to_phrase; end
  def recover_strength;[get, strengtheners].to_phrase; end
end
