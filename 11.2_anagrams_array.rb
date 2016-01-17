# ### Problem: 
# Write a method to sort an array of strings so that all the anagrams are next to each other.

# ### Clarifications: 
# what about white spaces, capitalizations and punctuations?

# ### Assumptions: 
# white spaces, cap, and punctuations will be ignored.
# putting anagrams next to each other in subarrays

# ### Solution: 

module Anagram
  module_function

  def sort_anagrams(array)
    array_full = array.dup
    matched = []

    while array.length > 0 do
      current = array.shift
      array.each do |word|
        if compare(word,current)
          match = array.delete(word)
          matched << [match, current]
        end 
      end 
    end

    no_match = array_full - matched.flatten

    p matched + no_match
  end

  def sort_word(word)
    #omit whitespaces, and non-word characters
    word.downcase.gsub(/\s*\W*/, "").chars.sort.join 
  end

  def compare(a,b)
    sort_word(a) == sort_word(b) ? true : false
  end
end

# ### Sample Output:
array = ["Indicatory", "Old West Action", "not matching", "Listen", "Dirty Room", "Dormitory", "rand0M", "noPe", "Silent", "Clint Eastwood", "FAIL", "Dictionary"]
Anagram.sort_anagrams(array)
# => [["Dictionary", "Indicatory"], ["Clint Eastwood", "Old West Action"], ["Silent", "Listen"], ["Dormitory", "Dirty Room"], "not matching", "rand0M", "noPe", "FAIL"]

