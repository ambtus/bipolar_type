# frozen_string_literal: true

# Restart required even in development mode when you modify this file.

%w[even odd intersect sixth multiply add join_strings duplicates discard replace_with
   purge remove_consecutive_dupes check_constraints and or amp lor wbr slash break semi
   to_phrase to_safe_phrase].each do |meth|
  raise "#{meth} is already defined in Array class" if Array.method_defined? meth
end

class Array
  def odd
    values_at(* each_index.select(&:odd?))
  end

  def even
    values_at(* each_index.select(&:even?))
  end

  def intersect(other)
    try = intersection(other)
    raise "intersection (#{try}) did not find exactly one" unless try.size == 1

    try.first
  end

  def multiply(target, method = :+)
    array_of_arrays = []
    each do |row|
      result = []
      target.each do |column|
        result << row.send(method, column)
      rescue StandardError
        row.to_s.send(method, column.to_s)
      end
      array_of_arrays << result
    end
    array_of_arrays
  end

  def add(target, method = :+)
    result = []
    target = Array.new size, target unless target.is_a? Array
    each_with_index do |row, index|
      result << row.send(method, target[index])
    end
    result
  end

  def join_strings(target, chars = '')
    result = []
    target = Array.new size, target unless target.is_a? Array
    each_with_index do |item, index|
      result << [item.to_s, target[index].to_s].join(chars)
    end
    result
  end

  def duplicates
    duplicates = {}
    each_with_index do |val, idx|
      (duplicates[val] ||= []) << idx
    end
    duplicates.delete_if { |_, v| v.size == 1 }.keys
  end

  def discard(element)
    reject { |x| x == element }
  end

  def replace_with(old, new)
    map { |x| x == old ? new : x }
  end

  #  def purge
  #    reject{|x| x.blank?}
  #  end
  alias purge :compact_blank

  def remove_consecutive_duplicates
    result = []
    last   = nil
    each do |o|
      result << o unless last == o
      last = o
    end
    result
  end

  def check_constraints(klass, min = 0, max = 100)
    raise "#{self} #{size} is not at least #{min}" unless count >= min
    raise "#{self} #{size} is more than #{max}" unless count <= max

    each { |x| raise "#{x} is not a kind of #{klass}" unless x.is_a? klass }
  end

  def sixth = self.[](5)

  def and = compact_blank.to_sentence
  def or = compact_blank.to_sentence(last_word_connector: ', or ', two_words_connector: ' or ')
  def amp = join(' & ')
  def lor = join(' | ')
  def semi = join('; ')
  def wbr = join('<wbr>').html_safe
  def break = join('<br />').html_safe
  def slash = join('/<wbr>').html_safe
  def to_phrase = join(' ').squish
  def to_safe_phrase = join(' ').squish.html_safe
end
