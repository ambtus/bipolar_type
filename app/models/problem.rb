class Problem < Concept

  def initialize(string)
    raise "#{string} length is not 2" unless string.length == 2
    @symbol = string
    @realm = Realm.send(symbol.first)
    @nurture = Nurture.send(symbol.second)
  end
  attr_reader :symbol, :nurture, :realm

  ALL = Nurture::ALL.collect do |nurture|
          Realm::ALL.collect do | realm |
            self.new(realm.symbol + nurture.symbol)
          end
        end.flatten

  def self.all; ALL; end
  def self.first; ALL.first; end
  ALL.each{|s| define_singleton_method(s.symbol) {s}}

  def index; ALL.index self; end

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end
  def +(realm); subtypes.find{|s| s.realm == realm}; end

  def method_missing(meth, *arguments, &block)
    if realm.respond_to?(meth)
      realm.send(meth, *arguments, &block)
    elsif nurture.respond_to?(meth)
      nurture.send(meth, *arguments, &block)
    else
      super
    end
  end

  def description; [adjective, problem].to_phrase; end

  def self.paths; ALL.map(&:path); end

  def siblings; attitude.subtypes + realm.subtypes - [self]; end

  def types; Type.all.select{|t| t.subtypes.include?(self)}; end


end
