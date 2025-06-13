class Subtype < Concept

  SYMBOL = Realm.all.collect do |realm|
             Attitude.all.collect do |attitude|
               (attitude.string.first + realm.string + attitude.string.second).to_sym
             end
          end.flatten

  ALL = SYMBOL.collect{|symbol| self.new symbol}

  def realm; Realm.find_by(string.second); end
  def attitude; Attitude.find_by(string.first + string.third); end

  def tla; [first_letter, letter, second_letter].join; end

  def action; [gu, es].to_phrase; end

  def act; realm.send(attitude.action); end

  def parts; [attitude, realm]; end # sort by attitude
  def next; realm + attitude.next; end
  def previous; realm + attitude.previous; end
  def opposite; realm+ attitude.opposite; end
  def flip; realm+attitude.flip; end
  def flop; realm+attitude.flop; end

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
