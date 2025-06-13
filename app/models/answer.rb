class Answer

  def self.first_path; 'Q1'; end
  def self.first; Answer.new(first_path); end

  def initialize(string)
    @path = string
    @question,answer_string,choice = @path.split(':')
    @choice = choice && (Realm.find(choice) || Attitude.find(choice))
    @answer_string = answer_string || ''
  end
  attr_reader :path, :question, :answer_string

  def first?; number.to_i == 1; end
  def number; @question.last ; end
  def finished?; number.to_i > 3; end

  def subtypes; answer_string.scan(/.../).collect{|s| Subtype.find(s)}; end

  def realms; subtypes.map(&:realm); end
  def chosen_realm; @choice if @choice.is_a?(Realm); end
  def free_realms; ([chosen_realm, *Realm.all] - realms).compact.uniq; end

  def attitudes; subtypes.map(&:attitude); end
  def chosen_attitude; @choice if @choice.is_a?(Attitude); end
  def free_attitudes; ([chosen_attitude, *Attitude.all] - attitudes).compact.uniq; end

  def free_things;( @choice.blank? || @choice.is_a?(Attitude) ) ? free_attitudes : free_realms; end
  def choice; free_things.first; end
  

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

  def last; free_attitudes.first + free_realms.first ; end
  def all; subtypes << last; end
  def sorted; all.sort.map(&:realm); end
  def type_path; sorted.map(&:string).join; end
end
