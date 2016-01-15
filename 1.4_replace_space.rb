# ### Problem:
# Write a method to replace all spaces in a string with '%20'. You may assume that the string has sufficient space at the end of the string to hold the additional characters, and that you are given the "true" length of the string. (Note: if implementing in Java, please use a character array so that you can perform this operation inplace.)

# ### Clarification:
# does sufficient space at the end mean "abc   " a string that can contain blank spaces at the end?
# if "abc   " string is given with 3 trailing spaces we want to output "abc%20%20%20"? is that correct?

# ### Assumptions:
# replace a single space with a single "%20"
# There are spaces to hold additional characters since " " takes 1 and "%20" takes 3 spaces

# ### Solution:

module MyString
  module_function

  def replace_space(string) #this Ruby implementation is different than the Java version in the CTCI. Let's try to do one without the 'gsub' method.
    string.gsub(' ', '%20')
  end

  def replace_space2(string)
    # TODO implement without builtin gsub
  end
end

# ### Sample Output:
string = "abc   "
p MyString.replace_space(string)
# => "abc%20%20%20"
