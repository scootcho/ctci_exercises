# ### Problem:
# Implement a function to check if a linked list is a palindrome

# ### Clarification:
# we're given a linked list with values in the nodes, they can be any data types like Strings, Integers?
# definition - A palindrome is a word, phrase, number, or other sequence of characters which reads the same backward or forward.
# palidrome means the given linked list will hold mirrored values when examining from both end of the list at the same time toward the middle?
# does capitalized characters / spaces matter? Example, is "Race car" a palindrome?
# Is this a singly or doubly linked list?

# ### Assumption:
# Do we know the length of the linked list? and is it a doubly linked list? If both is true we can start from the middle of the list and match outwards. 
# If we don't know the length that just means we must go to the end of the linked list.
# This is a singly linked list
# The space complexity is O(N) the order of magnitude will change in accordance to how big the linked list will be. 

# ### Solution #1: Reverse and Compare
# make a reversed copy of the linked list and compare it up to the middle of the list

# ### Solution #2: Iterative Approach
# if the length is known, push first half of the elements into a stack then compare the remaining of the linked list by starting to pop off the stack.
# if the length is unknown, we can use fast runner / slow runner. slow runner push into the stack as both runner goes. When fast runner hits the end the slow runner would have a stack with first two half of the elements. Then compare the remaining elements in the linked list by popping off the stack.

# ### Solution #3: Recursive Approach
# like many linked list problems, you can approach this problem recursively. Wemay have some intuitive idea that we want to compare element 0 and element n, element 1 and element n-1, element 2 and element n-2, and so on, until the middle element(s). For example:
# 0(1(2(3)2)1)0
# 0 == n, 1 == n-1, 2 == n-2 ...
# we need to know when the pointers reach the middle element of the list.
# book mentioned that we can do length - 2 for each call. so 7-2=5, 5-2=3, 3-1=1 <- middle! (but this is only optimal if you know the length of the list!)
# once you find the middle of list, compare the mirrored values outwards recursively

# ### Solution:
# TODO implment solution



# ### Additional Resources:
# https://en.wikipedia.org/wiki/Palindrome
