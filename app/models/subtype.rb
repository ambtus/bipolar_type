class Subtype

  def initialize(triplet, state)
    @triplet = triplet
    @state = state
  end
  attr_reader :triplet, :state

  def behavior; triplet.behavior; end
  def realm; triplet.realm; end

  def pair; [@triplet, @state]; end
  def <=>(other); pair <=> other.pair; end

  def path; pair.map(&:path).join; end
  def mbti; pair.reverse.map(&:mbti).wbr; end
  def display; pair.map(&:display).join; end
  alias inspect :display

  ALL = Triplet.all.collect do |triplet|
          State.all.collect do |state|
            self.new(triplet,state)
          end
        end.flatten

  class << self
    def find(thing)
      if thing.is_a? String
        self.send(thing)
      elsif thing.is_a? Array
        if thing.length == 2
          ALL.find{|s| s.triplet == thing.first && s.state == thing.second}
        elsif thing.length == 3
          ALL.find{|s| s.behavior == thing.first && s.realm == thing.second && s.state == thing.third}
        end
      end
    end
    def all; ALL; end
    def each(&block); ALL.each(&block); end


    def distress(realm, index)
      behavior = Behavior.sort_order[index]
      Subtype.find([behavior, realm, State.distress])
    end
  end

  ALL.each_with_index do |instance, index|
    %w{path}.each do |thing|
      define_singleton_method(instance.send(thing)) {ALL[index]}
      define_singleton_method(instance.send(thing).downcase) {ALL[index]}
    end
  end

  def guilt
    ALL.find do |s|
      s.behavior == behavior.guilt &&
      s.realm == realm &&
      s.state == State.guilt
    end
  end
  def eustress
    ALL.find do |s|
      s.behavior == behavior.eustress &&
      s.realm == realm &&
      s.state == State.eustress
    end
  end
  def happy
    ALL.find do |s|
      s.behavior == behavior.happiness &&
      s.realm == realm &&
      s.state == State.happiness
    end
  end

  def next; Subtype.find([@triplet.next, @state.next]); end
  def opposite; self.next.next; end
  def previous; opposite.next; end

  def cycle; Cycle.find_with(self); end

  def names;[*@triplet.names, @state.name, ]; end
  def name; names.wbr; end
  def symbolic_name; [display.colon, name].to_safe_phrase; end
  def clear_name; names.join; end

  def class; state.mbti.downcase; end

  def siblings
    if realm.generic?
      ALL.select do |s|
        s.behavior == behavior &&
        s.realm == realm &&
        ![state,State.distress].include?(s.state)
      end
    else
      ALL.select do |s|
        s.behavior == behavior &&
        ![realm, Realm.generic].include?(s.realm) &&
        ![state, State.distress].include?(s.state)
      end
    end.sort
  end

  def method_missing(meth, *arguments, &block)
    if realm.respond_to?(meth)
      realm.send(meth, *arguments, &block)
    elsif behavior.respond_to?(meth)
      behavior.send(meth, *arguments, &block)
    elsif state.respond_to?(meth)
      state.send(meth, *arguments, &block)
    elsif triplet.respond_to?(meth)
      triplet.send(meth, *arguments, &block)
    else
      super
    end
  end

end
