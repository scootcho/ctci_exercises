# ### Problem:
# Given two strings, write a method to decide if one is a permutation of the other.

# ### Clearifications:
# To confirm, permutation means an arrangement of objects in specific order. The order of the arrangement is important!!
# Remember the permutation notation is (nPr) n=total number, r=number chosen
# are these two strings equal lengths? or are we checking if the shorter string is a permutation of the longer string?
# Is it case sensitive? is "Dog" and "God" permutation of the other?

# ### Assumptions:
# Capitalzation, white spaces and punctuations are ignored
# two strings should be equal lengths ignoring white spaces 

# ### Solution:

module MyString
  module_function

  def permutation1?(string1, string2) # this method may not be as efficient but it's easily readable
    raise StringLengthError.new("two strings does not have the same length!") if (string1.length != string2.length)

    string1.chars.sort == string2.chars.sort ? true : false
  end

  def permutation2?(string1, string2) # this is the java translated version. I think it can be faster using Hash instead of Array in Ruby. Benchmarks says the first method is faster!
    raise StringLengthError.new("two strings does not have the same length!") if (string1.length != string2.length)

    array1 = Array.new(256, 0) #we're assuming a character set of 256 using ASCII
    array2 = Array.new(256, 0)

    i = 0
    while i < string1.length do
      index = string1[i].ord
      array1[index] += 1
      i += 1
    end

    x = 0
    while x < string2.length do
      index = string2[x].ord
      array2[index] += 1
      x += 1
      if array2[index] > array1[index] 
        false
      end
    end

    array1 == array2 ? true : false
  end

  def permutation3?(string1, string2) # based on benchmarking using Hash is almost as slow as using Array. Although a tiny bit faster.
    raise StringLengthError.new("two strings does not have the same length!") if (string1.length != string2.length)

    hash1 = Hash.new(0)
    hash2 = Hash.new(0)

    i = 0
    while i < string1.length do
      index = string1[i].ord
      hash1[index] += 1
      i += 1
    end

    x = 0
    while x < string2.length do
      index = string2[x].ord
      hash2[index] += 1
      x += 1
      if hash2[index] > hash1[index] 
        false
      end
    end

    hash1 == hash2 ? true : false

  end
end

class StringLengthError < StandardError; end

# ### Sameple Output:
string1 = ('a'..'z').to_a.shuffle.join
string2 = ('a'..'z').to_a.shuffle.join

p MyString.permutation1?(string1, string2)
# => true
p MyString.permutation2?(string1, string2)
# => true
p MyString.permutation3?(string1, string2)
# => true

### Benchmark:
require 'benchmark'

n = 100000

Benchmark.bmbm do |x|
  x.report("permutation1?")  { n.times do; MyString.permutation1?(string1, string2); end }
  x.report("permutation2?")  { n.times do; MyString.permutation2?(string1, string2); end }
  x.report("permutation3?")  { n.times do; MyString.permutation3?(string1, string2); end }
end

### Benchmark Results:
# Rehearsal -------------------------------------------------
# permutation1?   1.650000   0.000000   1.650000 (  1.652317)
# permutation2?   2.460000   0.020000   2.480000 (  2.511160)
# permutation3?   4.260000   0.010000   4.270000 (  4.272365)
# ---------------------------------------- total: 8.400000sec

#                     user     system      total        real
# permutation1?   1.550000   0.010000   1.560000 (  1.552221)
# permutation2?   1.860000   0.000000   1.860000 (  1.863867)
# permutation3?   3.970000   0.010000   3.980000 (  3.984141)


### Additional Resources:
# https://en.wikipedia.org/wiki/Permutation#Permutations_in_computing
