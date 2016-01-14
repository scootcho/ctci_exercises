# Problem
# Assume you have a method isSubstring which checks if one word is asubstring of another. Given two strings, s1 and s2, write code to check If s2 is a rotation of s1 using only one call to isSubstring (e.g., "waterbottle" is a rotation of "erbottlewat").


# Clarification
# do string1 and string2 have the same lengths?


# Assumptions


# Solution


module MyString
  module_function

  def is_substring?(string1, string2)
    raise EmptyStringError.new("string cannot be empty!") if (string1.empty? || string2.empty?)

    string1.include?(string2) ? true : false
  end

  def is_rotation?(string1, string2)
    raise EmptyStringError.new("string cannot be empty!") if (string1.empty? || string2.empty?)

    string3 = string1 + string1
    if string1.length != string2.length
      raise "strings lengths are not the same!"
    else
      is_substring?(string3, string2) 
    end
  end
end


class EmptyStringError < StandardError; end
