class Subtype < Concept

  SYMBOLS = Realm.all.collect do |realm|
             Attitude.all.collect do |attitude|
               (attitude.string.first + realm.string + attitude.string.second).to_sym
             end
          end.flatten

  ALL = SYMBOLS.collect{|symbol| self.new symbol}

  def realm; Realm.find(string.second); end
  def attitude; Attitude.find(string.first + string.third); end

  def tla; [first_letter, letter, second_letter].join; end
  def self.find_by_tla(string); ALL.find{|s| s.tla == string}; end

  def self.without(string)
    subtypes = string.scan(/.../).collect{|tla| Subtype.find_by_tla(tla)}
    Rails.logger.debug {"subtypes: #{subtypes}"}
    realms = subtypes.map(&:realm)
    attitudes = subtypes.map(&:attitude)
    Subtype.all.reject{|s| realms.include?(s.realm) || attitudes.include?(s.attitude)}
  end


  def episode; [ms, adjective, md].to_phrase.titleize; end

  def meth; [gu, es].join('_'); end
  def action; realm.send(meth); end

  def aka; [gu, adjective, es].to_phrase; end

  def parts; [attitude, realm]; end # sort by attitude
  def next; realm + attitude.next; end
  def previous; realm + attitude.previous; end
  def opposite; realm+ attitude.opposite; end
  def flip; realm+attitude.flip; end
  def flop; realm+attitude.flop; end

  def next_realm; realm.next + attitude; end

  def method_missing(meth, *args, **kwargs, &block)
    if attitude.respond_to?(meth)
      attitude.send(meth)
    elsif realm.respond_to?(meth)
      realm.send(meth)
    else
      super(meth)
    end
  end

end
