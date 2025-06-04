class Subtype < Concept

  SYMBOL = Realm.all.collect do |realm|
             Attitude.all.collect do |attitude|
               (attitude.dominant? ? realm.string + attitude.string : attitude.string + realm.string).to_sym
             end
          end.flatten

  ALL = SYMBOL.collect{|symbol| self.new symbol}

  def realm; Realm.find_by(string.first) || Realm.find_by(string.second); end
  def attitude; Attitude.find_by(string.second) || Attitude.find_by(string.first); end

  def parts; [realm, attitude]; end
  def next; realm + attitude.next; end
  def previous; realm + attitude.previous; end
  def opposite; realm+ attitude.opposite; end

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
