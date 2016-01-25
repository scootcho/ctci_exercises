# ### Problem:
# Implement a method to perform basic string compression using the counts of repeated characters. For example, the string a a b c c c c c a a a would become a2blc5a3. If the "compressed" string would not become smaller than the original string, your method should return the original string.

# ### Clarifications:
# when a character only has 1 count. are we compressing that? E.g., "aabbc" => "a2b2c" or "a2b2c1"?

# ### Assumptions:
# we're assuming that we're compressing a single character as well so "a" => "a1"

# ### Solution:

module MyString
  module_function

  def compress1(string) 
    uniq = Hash.new(0)
    string.chars.each {|w| uniq[w] += 1 }
    compressed_string = uniq.flatten.join
    compressed_string.length > string.length ? string : compressed_string
  end

  def compress2(string)
    # TODO additional implemention: follow Java Logic in CTCI
  end

  def compress3(string)
    # TODO additional implemention:e follow Java Logic with StringBuffer as in CTCI
  end

end


# ### Sample Output:
string = "aabcccccaaa"
p MyString.compress1(string)
# => "a5b1c5"
