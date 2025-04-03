class Answer

  def self.first_path; 'Q1'; end
  def self.first; Answer.new(first_path); end

  def initialize(string)
    @path = string
    @question,answer_string = @path.split(':')
    @answer_string = answer_string || ''
  end
  attr_reader :question, :path, :answer_string

  def number; @question.last ; end
  def finished?; number.to_i > 3; end

  def subtypes; answer_string.scan(/../).collect{|s| Subtype.find_by(s)}; end
  def behaviors; subtypes.map(&:behaviors).flatten; end

  def realms; subtypes.map(&:realm); end
  def attitudes; subtypes.map(&:attitude); end

  def taken?(subtype); realms.include?(subtype.realm) || attitudes.include?(subtype.attitude); end
  def chosen?(subtype); subtypes.include?(subtype); end

  def implied?(behavior); behaviors.include?(behavior); end

  def next(string); question.next + ':' + answer_string + string; end

  def last; Subtype.all.find{|s| !realms.include?(s.realm) && !attitudes.include?(s.attitude) }; end

  def all; (subtypes << last).sort_by(&:attitude); end

  def realm_string; all.map(&:realm).map(&:symbol).join; end
  def type_path; Type.find_by_realm_string(realm_string).path; end
end
