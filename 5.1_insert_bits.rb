# ### Problem:
# You are given two 32-bit numbers, N and M, and two bit positions, i and j. Write a method to insert M into N such that M starts at bit j and ends at bit i. You can assume that the bits j through i have enough space to fit all of M. That is, if M = 10011, you can assume that there are at least 5 bits between j and i. You would not, for example, have j=3 and i=2, because M could not fully fit between bit 3 and bit 2.
# EXAMPLE:
# Input: N = 10000000000, M = 10011, i = 2, j = 6 Output: N = 10001001100

# ### Clarifications:
# are we creating a method that will take 2 numbers upto 32 bits and inserting one into another based on two additonal bit position inputs?
# are we restricted to use bit operators like AND, NOT, XOR?
# are we clearning the bits between the two positions to 0?

# ### Assumptions:
# use bit operators.
# Note - you can convert integers to bits and perform operations
#
# irb>> "%07b" % 3  #create 7 digit binary string
# => "0000011"
# irb> 0b1101 #prefix with 0b for binary
# => 13
# irb> x = 123
# => 123
# irb> x.to_s(2)
# => "1111011"
# irb> shift = 1 << 5
# => 32
# irb> shift.to_s(2)
# => "100000"
# irb> xor = 001^100
# => 101

# ### Design Algorithm:
# This problem can be approached in three key steps:
# 1. Clear the bits j through i in N
# 2. Shift M so that it lines up with bits j through i
# 3. Merge M and N.

# ### Solution:
module MyBit
  module_function

  # as integers arguments defaults to base 10 and converted bits such as 1024.to_s(2) are String objects.
  # we'll be writing pseudo code for demonstration purposes

  def insert_bits(bits_n, bits_m, p1, p2)
    raise ArgumentError, "bits cannot not fit into another bits, please try again" if bits_m.to_s(2).length > p1 + p2

    p "inserting #{bits_m.to_s(2)} into #{bits_n.to_s(2)}"
    p "=========== BEGIN ============"

    # calculate total bit length
    p bits_n.to_s(2)
    p "bit length:"
    p bit_length = bits_n.to_s(2).length 
    # => 11

    p "inserting 1s to left:"
    ones_l_num = (~0 << p1)
    p ones_l_bits = MyBit.to_binary(ones_l_num, bit_length)
    
    p "inserting 1s to right:"
    ones_r_num = ((1 << p2) - 1)
    ones_r_bits = MyBit.to_binary(ones_r_num, bit_length)

    p "creating mask using OR:"
    p ones_l_bits
    p "OR"
    p "000000000" + ones_r_bits
    mask_num = ones_l_num | ones_r_num
    p "mask:"
    p mask_bits = MyBit.to_binary(mask_num, bit_length)

    p "*** clearing bits using mask ***"
    p bits_n.to_s(2)
    p mask_bits
    p "*** cleared bits: ***"
    cleared_num = bits_n & mask_num 
    p cleared_bits = MyBit.to_binary(cleared_num, bit_length)

    p "*** shifting M into correct position ****"
    p bits_m.to_s(2)
    p "shifted:"
    shifted_m_num = bits_m << p2 
    p shifted_m_bits = MyBit.to_binary(shifted_m_num, bit_length)

    p "*** inserting shifted M into cleared N using OR***"    
    p cleared_bits    
    p "OR"
    p shifted_m_bits
    result_num = cleared_num | shifted_m_num
    p "*** RESULT ***"
    p MyBit.to_binary(result_num, bit_length)
    p "=========== FINISH ============"
    
  end

  def to_binary(num, length)
    return "0" if num == 0

    r = []

    length.times do
      if (num & (1 << length - 1)) != 0
        r << 1
      else
        (r << 0) if r.size > 0
      end
      num <<= 1
    end

    r.join
    # http://stackoverflow.com/questions/31212079/converting-integers-to-binary-in-ruby
  end

end


# ### Sample Output:
n = "10000000000".to_i(2)
# => 1024
m = "10011".to_i(2)
# => 19
m.class
# => Fixnum
p1 = 6
p2 = 2
MyBit.insert_bits(n, m, p1, p2)
# => "10001001100"


# ### Additional Resources:
# http://stackoverflow.com/questions/791328/how-does-the-bitwise-complement-operator-work
# http://stackoverflow.com/questions/13438994/signed-2s-complement-for-a-hexadecimal-number
# http://stackoverflow.com/questions/31212079/converting-integers-to-binary-in-ruby
