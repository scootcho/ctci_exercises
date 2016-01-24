# ### Problem:
# Imagine a robot sitting on the upper left comer of an X by Y grid. The robot can only move in two directions: right and down. How many possible paths are there for the robot to go from (0, 0) to (X, Y) ?
# FOLLOW UP
# Imagine certain spots are "off limits," such that the robot cannot step on them. Design an algorithm to find a path for the robot from the top left to the bottom right.

# ### Clarification:

# ### Solutoin:
# great explaination of Binomial expressions at Khan Academy
# https://www.khanacademy.org/math/algebra2/polynomial-functions/binomial-theorem/v/binomial-theorem

# Think about each path as a string of length X+Y consisting X 'R's and Y 'DJs. We know that the number of strings we can make with X+Y unique characters is (X+Y)!.

# (2,2) -> (0,0)
# 2+2 > 2+1 > 2+0 > 1+0 > 0+0
# 2+2 > 2+1 > 1+1 > 1+0 > 0+0
# 2+2 > 2+1 > 1+1 > 0+1 > 0+0
# 2+2 > 1+2 > 0+2 > 0+1 > 0+0
# 2+2 > 1+2 > 1+1 > 0+1 > 0+0
# 2+2 > 1+2 > 1+1 > 1+0 > 0+0

# However, in this case, X of the characters are 'R's and Y are 'D's. Since the 'R's can be rearranged in X! ways, each of which is identical, and we can do an equivalent thing with the 'D' s, we need to divide out by X! and Y!. We then get the same expression as we had before:

# (X+Y)!/X!*Y!
# (2+2)!/2!*2! = 4x3x2x1/2*2 = 6


# Follow Up: Find a path (with off limit spots)
@off_limit = []
def set_off_limits(x,y)
  @off_limit << [x,y]
end

def is_free?(x, y)
  if @off_limit.include?([x,y])
    false
  else
    true
  end
end

def get_path(x, y, path = []) 
  path << [x, y]
  if ( x == 0 && y == 0) # this means it reaches the starting poing at (0, 0), complete path found.
    return true
  elsif ( x >= 1 && is_free?( x - 1, y ))
    success = get_path( x - 1, y, path)
  elsif ( !success && y >= 1 && is_free?( x, y - 1))
    success = get_path( x, y - 1, path)
  else
    path << [x, y]
  end
  return path
end


# ### Sample Output:
set_off_limits(4,10)
set_off_limits(3,9)
set_off_limits(2,9)
set_off_limits(2,8)
set_off_limits(1,6)
get_path(5, 10)
# => [[5, 10], [5, 9], [4, 9], [4, 8], [3, 8], [3, 7], [2, 7], [1, 7], [0, 7], [0, 6], [0, 5], [0, 4], [0, 3], [0, 2], [0, 1], [0, 0]]
