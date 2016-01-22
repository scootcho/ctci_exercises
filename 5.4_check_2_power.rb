### Problem:
# Explain what the following code does: ((n & (n-1)) == 0).

### Claifications:
# is the code part of a method or is it a method on its own?
# is this a method that performs a boolean check?

### Assumptions:
# the piece of code can be a method itself.

### Solution:
# TODO implement solution. Write explaination here.

module MyBit
  module_function

  def power_of_2?(n)
    ( n & (n-1)) == 0
  end
end


# ### Sample Output:

p MyBit.power_of_2?(4)
# => true
p MyBit.power_of_2?(6)
# => false
p MyBit.power_of_2?(8)
# => true
p MyBit.power_of_2?(10)
# => false
p MyBit.power_of_2?(16)
# => true
