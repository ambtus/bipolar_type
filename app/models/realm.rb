class Realm < Concept

  ########
  ACRONYMS = %w{s t f n}
  ALL = ACRONYMS.collect {|letter| self.new letter}
  ACRONYMS.each do |letter|
    define_singleton_method(letter) {ALL[ACRONYMS.index(letter)]}
  end
  %w{first second third fourth}.each_with_index do |ordinal, index|
    define_singleton_method(ordinal) {ALL[index]}
  end
  ########

  def locale; path.to_sym; end

  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  def +(attitude); subtypes.find{|s| s.attitude == attitude}; end

  def mbti; path.upcase; end

  def realm
    I18n.locale = self.locale
    I18n.t :adjective
  end

  def name; realm.capitalize; end

end
