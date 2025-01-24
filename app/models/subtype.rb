class Subtype < Concept

  SYMBOL = Realm::SYMBOL.collect do |realm|
             Attitude::SYMBOL.collect do |attitude|
                realm + attitude
            end
          end.flatten

  ALL = SYMBOL.collect{|symbol| self.new symbol}

  def realm; Realm.find_by(symbol.first); end
  def attitude; Attitude.find_by(symbol.second); end

  def parts; [attitude, realm]; end
  def peers; attitude.subtypes.without(self); end
  def siblings; realm.subtypes.without(self);end

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
