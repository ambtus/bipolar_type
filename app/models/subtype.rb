class Subtype < Phrase

  def initialize(array)
    @realm = array.first
    @attitude = array.second
    super
  end
  attr_reader :realm, :attitude

  ALL = Attitude::ALL.collect do |attitude|
          Realm::ALL.collect do |realm|
            self.new [realm,attitude]
          end
        end.flatten
  def self.all; ALL; end

  def unordered_pair; [attitude, realm]; end
  def pair; attitude.after? ? unordered_pair.reverse : unordered_pair; end

  def mbti; Noun.new pair.map(&:mbti).join; end
  def inspect; pair.map(&:inspect).join; end
  def path; pair.map(&:path).join; end
  def to_s; path.to_s; end
  def to_str; to_s; end

  def <=>(other); attitude.index <=> other.attitude.index; end


  ALL.each{|s| define_singleton_method(s.path) {s}}
  def self.paths; ALL.map(&:path); end

  def peers; ALL.select{|s| s.realm == realm || s.attitude == attitude} - [self]; end
  def discover_path; Answer.first.next(self); end

  def same_realm; ALL.select{|s| s.realm == realm}; end
  def same_attitude; ALL.select{|s| s.attitude == attitude}; end

  def method_missing(meth, *arguments, &block)
    if attitude.respond_to?(meth)
      attitude.send(meth, *arguments, &block)
    elsif realm.respond_to?(meth)
      realm.send(meth, *arguments, &block)
    else
      super
    end
  end

  def cadvice; attitude.cadvice(consume); end
  def padvice; attitude.padvice(produce); end

  def adjective; Phrase.new [adverb, attitude.adjective]; end
  def name; Phrase.new [adjective.titleize, mbti.parenthesize]; end

end
