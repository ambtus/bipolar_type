class Subtype

  def initialize(array)
    @pair = array
    @realm = array.first
    @attitude = array.second
  end
  attr_reader :realm, :attitude

  ALL = Realm::ALL.collect do |realm|
               Attitude::ALL.collect do |attitude|
                  self.new [realm,attitude]
                end
            end.flatten

  def self.all; ALL; end


  def peers; ALL.select{|s| s.realm == realm || s.attitude == attitude} - [self]; end
  def wings; ALL.select{|s| attitude.wings.include? s.attitude}; end
  def answer_path; Answer.first.next(self); end

  def <=>(other); [attitude, realm] <=> [other.attitude, other.realm]; end

  def method_missing(meth, *arguments, &block)
    if realm.respond_to?(meth)
      realm.send(meth, *arguments, &block)
    elsif attitude.respond_to?(meth)
      attitude.send(meth, *arguments, &block)
    else
      super
    end
  end

  def mbti; [@attitude.mbti.first, @realm.mbti, @attitude.mbti.second].join; end
  def inspect; mbti; end
  def path; mbti; end
  def symbol; path.upcase; end

  ALL.each{|s| define_singleton_method(s.path) {s}}
  def self.paths; ALL.map(&:path); end

  def description
    [@realm.description, @attitude.description].join(" ")
  end
  def name; description.titleize; end

  def siblings; (Subtype.all.select{|s| s.realm == @realm || s.attitude == @attitude}) - [self]; end

end
