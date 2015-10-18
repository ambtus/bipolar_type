class Realm

  # touch realm.rb to reload realm.csv in development mode
  require 'csv'
  arr_of_arrs = CSV.read("config/initializers/realm.csv")
  LETTERS = arr_of_arrs.shift
  arr_of_arrs.each {|row| define_method(row.first.gsub(' ', '_')) {row[@index] || row.first}}

  def initialize(letter)
    raise "#{letter} isn't an Realm" unless LETTERS.include?(letter)
    @index = LETTERS.index(letter)
    @path = letter
  end
  attr_reader :index, :path

  REALMS = LETTERS.collect{|letter| Realm.new(letter)}
  def self.all; REALMS[1,4]; end
  def self.generic; REALMS.first; end
  def self.find(letter); REALMS[LETTERS.index(letter)]; end

  def +(attitude); Subtype.find(self.path + attitude.path); end
  def subtypes; Attitude.all.add(self); end

  LETTERS.each {|r| define_singleton_method(r) {find(r)}}

  Attitude::LETTERS.each_with_index { |path, index| define_method(path) {subtypes[index]}}

  def name; generic.capitalize; end

  def consume_strength; [consume, strength].join(" "); end

  def gsub(attitude_string)
    attitude_string.
    gsub("consume", consume).
    gsub("consuming", consume.ing).
    gsub("inputting", input.ing).
    gsub("input", input).
    gsub("outputting", output.ing).
    gsub("output", output).
    gsub("out of energy", out_of_energy).
    gsub("out of strength", out_of_strength).
    gsub("be energetic", be_energetic).
    gsub("be strong", be_strong).
    gsub("being energetic", be_energetic.ing).
    gsub("being strong", be_strong.ing).
    gsub("too much energy", too_much_energy).
    gsub("too little energy", too_little_energy).
    gsub("too much strength", too_much_strength).
    gsub("too little strength", too_little_strength).
    gsub("provide for yourself", provide_for_yourself).
    gsub("take care of yourself", take_care_of_yourself).
    gsub("energy", energy).
    gsub("strength", strength)
  end

end
