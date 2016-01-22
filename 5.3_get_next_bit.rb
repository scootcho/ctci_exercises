# ### Problem:
# Given a positive integer, print the next smallest and the next largest number that have the same number of bits in their binary representation.

# ### Clarifications:
# are we creating a method that takes an integer and will output the next smallest and next largest integer that has the same numbers of 1s and 0s in their binary form?
# can we use arrays for bit manipulation?

# ### Assumptions:
# if we switch a bit 0 to 1, we must switch another bit from 1 to 0 to maintain same numbers of 1s and 0s

# ### Design Algorithm:
# next biggest bit:
# find the first 0 that has at least one 1 its right. We'll call this P
# Example: 11011000 ( the first 0 that has 1 on the RIGHT is at the 6th position from the right 11[0]11000 )
# switch P from 0 to 1, change the first 0 bit on the furthest right to 1
# shift all the remaining 1s to the far right followed by 0s going from right to left E.g., 0011
# next biggest bit of example: 11100011
#
# next smallest bit:
# find the first 1 that has at least one 0 on its right. We'll call this P
# Example: 11011001 ( the first 1 that has 0 on the RIGHT is at the 4th position from the right 1101[1]001 )
# switch P from 1 to 0, change the first bit on the RIGHT of P from 0 to 1.
# shift the remaining 1s next to the new P follow by 0s going from left to right. E.g., 1100
# next smallest bit of example: 11010110


# ### Solution:

module MyBit
  module_function

  def get_next(num)
    num_array = num.to_s(2).split("")
    previous = -1
    current = previous - 1
    n = 0

    p = while n < num_array.length
      if num_array[current] < num_array[previous]
        break current
      else
        previous = current
        current = current - 1
        n += 1
      end
    end

    remain = num_array[p+1..-1] # remaining bits to the right of p
    ones = remain.count("1") - 1 
    zeros = remain.count("0") + 1
    remain_shifted = Array.new(zeros, "0") + Array.new(ones, "1")

    num_array[p+1..-1] = remain_shifted
    num_array[p] = 1

    p "next smallest number:"
    p num_array.join
    p num_array.join.to_i(2)
  end

  def get_prev(num)
    num_array = num.to_s(2).split("")
    previous = -1
    current = previous - 1
    n = 0

    p = while n < num_array.length
      if num_array[current] > num_array[previous]
        break current
      else
        previous = current
        current = current - 1
        n += 1
      end
    end
     
    remain = num_array[p+1..-1] # remaining bits to the right of p
    ones = remain.count("1") + 1 
    zeros = remain.count("0") - 1
    remain_shifted = Array.new(ones, "1") + Array.new(zeros, "0")

    num_array[p+1..-1] = remain_shifted
    num_array[p] = 0

    p "next biggest number:"
    p num_array.join
    p num_array.join.to_i(2)

  end

end


### Sample Output:
# "11011010001111".to_i(2)
# => 13967 #answer to smallest
MyBit.get_next(13948)
# => 13967

# "10011101110000".to_i(2)
# => 10096 #answer to biggest
MyBit.get_prev(10115)
# => 10096


