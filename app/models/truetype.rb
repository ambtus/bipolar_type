class Truetype

  def initialize(string)
    @subtypes = string.scan(/../).collect{|x| Subtype.find(x)}
  end

  attr_reader :subtypes

  def dominant; subtypes.first; end
  def auxiliary; subtypes.second; end

  def realms; subtypes.map(&:realm); end
  def non_realms; Realm.all - realms; end

  def mbti; (dominant.mbti + auxiliary.realm.mbti).mbti_order; end

  def love; dominant.shorter; end
  def like; auxiliary.shorter; end
  def indifferent; non_realms.map(&:shorter) ;end
end
