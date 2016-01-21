# ### Problem:
# Given a real number between 0 and 1 (e.g., 0.72) that is passed in as a double, print the binary representation. If the number cannot be represented accurately in binary with at most 32 characters, print "ERROR."

# ### Clarifications:
# What does is a double?
# we're provided numbers between 0 and 1 as arguments and we want to convert the real number to 32 bit binary?
# due to how computer store decimal numbers should we round the result of the floats?
# > 0.72 - 0.5
# => 0.21999999999999997    #instead of 0.22

# ### Assumptions:
# Calculating floating pionts (base10): 22.589 = 2*(10^1) + 2*(10^0) + 5*(10^-1) + 8*(10^-2) + 9*(10^-3)
# Calculating floating pionts (base2): 1.001 = 1*(2^0) + 0*(2^-1) + 0*(2^-2) + 1*(2^-3)
# round the result to 4 decimals

# ### Design Alogrithm:
# Binaries from 4 to -4: 16, 8, 4, 2, 1, 1/2, 1/4, 1/8, 1/16
# we can see from the above pattern that the intervals are decreasing at n = n/2
# start with 0.5 since 2^-1 = 0.5
# add 1 to result if float >= interval, 0 if float < invterval
# repeat until float is equal to 0

# ### Solution:

module MyBit
  module_function

  def float_to_bit(float)
    "ERROR" if (float >= 1 || float <= 0)

    bits = []
    bits << "0." #appending floating point
    interval = 0.5

    while float.round(4) > 0
      p float
      return "ERROR longer than 32 bits!" if bits.length >= 32

      if float >= interval
        bits << 1
        float -= interval
      else
        bits << 0
      end
      interval = interval / 2
    end
    bits.join("")
  end

end


# ### Sample Output:
float = 0.72
p MyBit.float_to_bit(float)
#=> "0.101110000101"


# ### Additional Resources:
# http://kipirvine.com/asm/workbook/floating_tut.htm
# http://programmers.stackexchange.com/questions/167147/why-dont-computers-store-decimal-numbers-as-a-second-whole-number
