class Type

  def self.my_path; "efpm"; end
  def self.my_type; self.new my_path; end

  def initialize(string)
    @path = string
    @realms = @path.scan(/./).collect{|r| Realm.send(r)}
    @realms.uniq.check_constraints Realm, 4, 4
  end
  attr_reader :path, :realms

  def subtypes; realms.add(Attitude.all); end

  def symbol; subtypes.map(&:symbol).join("•"); end
  def inspect; symbol; end

  def likes; subtypes.values_at(2,0).map(&:consume) + subtypes.values_at(1,3).map(&:produce); end
  def name; likes.to_sentence(last_word_connector: ", & ").titleize.html_safe; end

  def self.all;Realm.paths.permutation(4).map(&:join).collect{|p| new(p)};end

end
