class Answer

  def self.first_path; 'Q1'; end
  def self.first; Answer.new(first_path); end

  def initialize(string)
    @path = string
    @question,answer_string,choice = @path.split(':')
    @choice = choice && (Attitude.find_by(choice) || Realm.find_by(choice))
    @answer_string = answer_string || ''
  end
  attr_reader :question, :path, :answer_string, :choice

  def first?; number.to_i == 1; end
  def number; @question.last ; end
  def finished?; number.to_i > 3; end

  def subtypes; answer_string.scan(/.../).collect{|s| Subtype.find_by(s)}; end
  def realms; subtypes.map(&:realm); end
  def attitudes; subtypes.map(&:attitude); end

  def taken?(thing)
    if thing.is_a?(Attitude)
      attitudes.include?(thing)
    elsif thing.is_a?(Realm)
      realms.include?(thing)
    elsif thing.is_a?(Subtype)
      realms.include?(thing.realm) || attitudes.include?(thing.attitude)
    end
  end

  def next(thing)
    if thing.is_a?(Subtype)
      "#{@question.next}:#{@answer_string}#{thing.string}:"
    else
      "#{@question}:#{@answer_string}:#{thing.string}"
    end
  end

  def last_attitude; (Attitude.all - attitudes).first; end
  def last_realm; (Realm.all - realms).first; end
  def last; last_attitude + last_realm ; end
  def all; subtypes << last; end
  def sorted; all.map(&:opposite).sort.map(&:realm); end
  def type_path; sorted.map(&:string).join; end
end
