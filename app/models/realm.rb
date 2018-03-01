class Realm < Concept

  ########
  ACRONYMS = %w{f t s n}
  ALL = ACRONYMS.collect {|letter| self.new letter}
  ACRONYMS.each do |letter|
    define_singleton_method(letter) {ALL[ACRONYMS.index(letter)]}
  end
  %w{first second third fourth}.each_with_index do |ordinal, index|
    define_singleton_method(ordinal) {ALL[index]}
  end
  ########

  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  def +(attitude); subtypes.find{|s| s.attitude == attitude}; end

  def adjective; %w{spiritual material physical mental}[index]; end
  def name; adjective.capitalize; end
  def symbol; name.first; end


  def overwhelmed; %w{upset angry sick afraid}[index]; end

  def consume; %w{listen take eat watch}[index]; end
  def consum; consume.gsub(/e$/, ''); end
  def consuming; consum + "ing"; end
  def consumer; %w{listener worker eater watcher}[index]; end

  def produce; %w{talk give exercise think}[index]; end
  def produc; produce.gsub(/e$/, ''); end
  def producing; produc + "ing"; end
  def producer; %w{preacher boss athlete thinker}[index]; end

  def fatigued; %w{misunderstood indebted sore stupid}[index]; end

end
