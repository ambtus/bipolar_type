class Answer

  def self.first_path; 'Q1'; end
  def self.first; Answer.new(first_path); end

  def initialize(string)
    @path = string
    @question,realm_string = @path.split(':')
    @realm_string = realm_string || ''
  end
  attr_reader :question, :path, :realm_string

  def realms; @realm_string.chars.collect{|s| Realm.send(s)}; end

  def number; @question.last.to_i ; end
  def index; number - 1; end
  def phase; Phase.linear[index]; end

  def free; Realm.all - realms; end
  def free?(behavior); free.include?(behavior.realm); end
  def finished?; free.empty?; end

  def next(behavior); question.next + ':' + @realm_string + behavior.realm.path; end

  def type_index;Type.find_by_realms(@realm_string).index; end

end
