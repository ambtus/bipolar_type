class Type

  def initialize(array)
    @emoji = array
    @symbol = array.join
  end
  attr_reader :symbol, :emoji

  ALL = Realm.symbols.permutation(4).collect{|p| new(p)}
  class << self
    def all; ALL; end
    def each(&block); ALL.each(&block); end
    def my_realms; %w{S F N T}; end
    def my_type; ALL.find{|type| type.emoji == my_realms}; end
    def generic_realms; Realm::ARROWS ; end
    def generic; Type.new(generic_realms); end
  end

  def inspect; @symbol; end
  def path; inspect ; end
  def index; ALL.index self; end

  %w{first second third fourth}.each do |ordinal|
    define_method(ordinal + "_realm") {Realm.send @emoji.send(ordinal)}
  end

end

