# ### Problem:
# Write a function to swap a number in place (that is, without temporary variables)

# Example:
# swap:
# a = 9, b = 4
# to:
# a = 4, b = 9

# process:
# a = a - b #5
# b = b + a #9
# a = b - a #4

# output:
# a = 4, b = 9

# ### Solution:

def swap_num(a,b)
  p "swapping - a:#{a}, b:#{b}"
  if a > b
    a = a - b
    b = b + a
    a = b - a
    "result - a:#{a}, b:#{b}"
  else
    b = b - a
    a = a + b
    b = a - b
    "a:#{a}, b:#{b}" # !> possibly useless use of a literal in void context
    "result - a:#{a}, b:#{b}"
  end
end


# ### Sample Output:

swap_num(9,5)
# =>
# "swapping - a:9, b:5"
# "result - a:5, b:9"

swap_num(5,9) 
# =>
# "swapping - a:9, b:5"
# "result - a:9, b:5"

swap_num(5,5)
# =>
# "swapping - a:5, b:5"
# "result - a:5, b:5"
