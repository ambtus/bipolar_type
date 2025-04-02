class Subtype < Concept

  SYMBOL = Realm.all.collect do |realm|
             Attitude.all.collect do |attitude|
               attitude.dominant? ? realm.symbol + attitude.symbol : attitude.symbol + realm.symbol
             end
          end.flatten

  ALL = SYMBOL.collect{|symbol| self.new symbol}

  def realm; Realm.find_by(symbol.first) || Realm.find_by(symbol.second); end
  def attitude; Attitude.find_by(symbol.second) || Attitude.find_by(symbol.first); end

  def parts; [attitude, realm]; end
  def opposite; realm+ attitude.opposite; end
  def peers; attitude.subtypes.without(self); end
  def siblings; realm.subtypes.without(self);end
  def flip; realm + attitude.opposite; end

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
