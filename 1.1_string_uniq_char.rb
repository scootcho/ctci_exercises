# Problem:
# Implement an algorithm to determine if a string has all unique characters. What if you cannot use additional data structures?


# Clarifications:
# It does not make sense to have a string without knowing what encoding it uses...There Ain't No Such Thing As Plain Text. - Joel on Software
# Is the string an ASCII or Unicode?
# Are we talking about English characters? If so is capital characters distict from lower case characters?
# We're creating a boolean method that will return true if a string have all different characters and false if there are any duplicates?


# Assumptions:
# let's call this method has_uniq_chars? that takes a String as an argument
# If the given string is "abc" it'll return true. If "aabc" it'll return false. 
#
# Notes:
# string to ascii and vice versa
#
# "A".ord
# => 65
#
# 65.char
# => "A"
#
#
# String to UTF-8 
#
# "\u2713".encode('utf-8')
# => "✓"
#
# "a".ord.to_s(16)
# => "61"
#
# "\u0061".encode('UTF-8')
# => "a"


# Solution:

module MyString
  module_function #in place of using extend self
  
  # Book's implementation with array
  # def has_uniq_chars?(string) 
  #   if string.length > 256
  #     false
  #   else
  #     char_set = []
  #     i = 0
  #     while i < string.length
  #       value = string[i]
  #       if char_set.include?(value)
  #         return false
  #       else
  #         char_set << value
  #         i += 1
  #       end
  #     end
  #     return true
  #   end
  # end

  # The time complexity for this code is O(n), where n isthe length of the string. The space complexity is O(1).

  def has_uniq_chars?(string) 
    if string.length > 256
      false
    else
      uniq = Hash.new(0)
      string.chars.each do |char|
        if uniq[char] == 0
          uniq[char] += 1
        else
          return false
        end
      end
      return true, uniq 
    end
  end

  # We can reduce our space usage by a factor of eight by using a bit vector. TODO implement this faster version. Need to figure out how this reduce by factor of 8
end



# Additional Resources:
# http://www.joelonsoftware.com/articles/Unicode.html
# http://www.theasciicode.com.ar/
# https://en.wikipedia.org/wiki/UTF-8#Examples
# https://en.wikipedia.org/wiki/Hexadecimal
# http://stackoverflow.com/questions/5924105/how-many-characters-can-be-mapped-with-unicode
# https://en.wikipedia.org/wiki/Bit_array
