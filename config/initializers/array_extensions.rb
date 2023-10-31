# Restart required even in development mode when you modify this file.

%w{to_wbr clip multiply add duplicates remove_consecutive_dupes check_constraints sixth and or to_phrase hash_for_mode }.each do |meth|
 raise "#{meth} is already defined in Array class" if Array.method_defined? meth
end

class Array

  def to_wbr; join('<wbr>'); end

  def clip n=1
    take size - n
  end

  def multiply(target, method=:+)
    array_of_arrays = []
    self.each do |row|
      result = []
      target.each do |column|
        result << row.send(method, column)
      end
      array_of_arrays << result
    end
    array_of_arrays
  end

  def add(target, method=:+)
    result = []
    target = Array.new self.size, target unless target.is_a? Array
    self.each_with_index do |row,index|
      result << row.send(method, target[index])
    end
    result
  end

  def duplicates
    duplicates = {}
    each_with_index do |val, idx|
      (duplicates[val] ||= []) << idx
    end
    duplicates.delete_if {|k,v| v.size == 1}.keys
  end

  def remove_consecutive_duplicates
    result = []
    last   = nil
    each do |o|
      result << o unless last==o
      last = o
    end
    result
  end

  def check_constraints(klass,min=0,max=100)
    raise "#{self} #{size} is not at least #{min}" unless count >= min
    raise "#{self} #{size} is more than #{max}" unless count <= max
    each{|x| raise "#{x} is not a kind of #{klass}" unless x.is_a? klass}
  end

  def sixth; self[5]; end

  def and; to_sentence; end
  def or; to_sentence(last_word_connector: ", or ", two_words_connector: " or "); end
  def to_phrase; join(" ").squish; end

  # group_by(&:itself).transform_values(&:count)
  # inject(Hash.new(0)) { |h,v| h[v] += 1; h }
  def hash_for_mode
  hash = Hash.new(0)
  self.each {|i| hash[i]+=1}
  hash
  end

end
