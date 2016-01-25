# ### Problem:
# Implement a function void reverse (char* str) in C or C++ which reverses a null-terminated string.

# ### Clarification:
# Does Ruby use null-terminated strings?
# This problem requires knowledge of C / C++.
# What is a Null-Termminated String?  "hi" is the same as {'h', 'i', '\0'} 
# The input will be a null-terminated string and we want the output to be the reverse of the string without the null, '\0'? Or do we need the null at the end of the string?

# ### Assumption:
# null = "\u0000" in ruby
# E.g.,
# irb> null_string = "\0"
# => "\u0000"
# "\u0000" is treated as a character in a string.
# abc = "ab\u0000cd\u0000\ef\u0000"; abc.reverse => "\u0000f\e\u0000dc\u0000ba"
# This means that if there is a null-terminated value, it will be treated as a character and be reversed along with other characters in the string.

# ### Solution:

module MyString
  module_function

  def reverse(string)
    i = 1
    reversed_chars = []
    while i < string.length + 1 do
      reversed_chars << string[-i] #this will start from -1, -2, -3, ... and put them into the new array
      i += 1
    end
    reversed_chars.join("")
  end
end

# ### Sample Output:
abc = "ab\u0000cd\u0000\ef\u0000"
# => "ab\u0000cd\u0000\ef\u0000"
p MyString.reverse(abc)
# => "\u0000f\e\u0000dc\u0000ba"


# ### Additional Resources:
# Null-Terminated String - https://en.wikipedia.org/wiki/Null-terminated_string
# character string stored as an array containing the characters and terminated with a null character ('\0', called NUL in ASCII). 
# Example - "hi" is the same as {'h', 'i', '\0'} 
