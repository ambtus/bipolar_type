class Realm < Concept

  ########
  ACRONYMS = %w{s n f t}
  ALL = ACRONYMS.collect {|letter| self.new letter}
  ACRONYMS.each do |letter|
    define_singleton_method(letter) {ALL[ACRONYMS.index(letter)]}
  end
  ########

  def locale; path.to_sym; end

  def self.locales; ACRONYMS.map(&:to_sym); end

  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  def +(attitude); subtypes.find{|s| s.attitude == attitude}; end

  def realm
    I18n.locale = self.locale
    I18n.t :adjective
  end

  def name; realm.capitalize; end
  def symbol; name.first; end

end
