# ### Problem:
# Imagine you have a 20 GB file with one string per line. Explain how you would sort the file.

# ### Clarifications:
# How much memory do we have?

# ### Assumptions:
# limited memory space; file size > memory size
# external sort

# ### Solution:
# External sort:
# 1. Divide the file into chunks which are x megabytes each, where x is the amount of memory we have available.
# 2. Each chunk is sorted separately and then saved back to the file system.
# 3. Once all the chunks are sorted, then merge the chunks, one by one. Write the larger sorted chunks to disk.
# At the end, we have a fully sorted file.

module Sort
  module_function

  # TODO code can be refactored and cleaned up. Come back to it later

  def external_sort(array, memory_size=4)
    full_length = array.length 
    num_chunks = (full_length / memory_size.to_f).ceil
    start = 0
    chunk = 0
    memory_store = []

    p "***** total file size: #{full_length}"
    p "***** total chunks: #{num_chunks}"
    p "***** sorting chunks based on memory size of #{memory_size}"

    while chunk < num_chunks
      memory_store = array[start...start + memory_size] #when start + memory_size exceeds array size, Ruby automatically gets remaining elements
      memory_store.sort!
      array[start...start + memory_size] = memory_store
      start += memory_size
      chunk += 1 
    end
    p "***** chunks sorted!:"
    p array.each_slice(memory_size).to_a

    pass = 0
    p1 = 0 
    p2 = p1 + 1

    loop do
      break if Sort.sort_check(array.flatten) == true

      sort_size = memory_size * (2** pass)
      memory_store = []
      output = []

      array = array.each_slice(sort_size).to_a
      p "***** merging chunks..."
      p array
      p "chunk_size: #{sort_size}"
      p "memory size: #{memory_size}"
      p "merge pass ##{pass + 1}"
      
      loop do

        break if array.empty? || array.count == 1 

        value1 = array[p1].shift
        value2 = array[p2].shift

        until array[p1].empty? && array[p2].empty? do
        # p "value1: #{value1}"
        # p "value2: #{value2}"
          if value1 == nil ||  value2 == nil
            if value1 == nil
              memory_store << value2
              value2 = array[p2].shift
            elsif value2 == nil
              memory_store << value1
              value1 = array[p1].shift
            end
          elsif value1 < value2
            memory_store << value1
            value1 = array[p1].shift
          elsif value1 > value2
            memory_store << value2
            value2 = array[p2].shift
          end

          if memory_store.count >= memory_size
            output << memory_store
            memory_store = []
          end
        end
  
        # resolve remainined assigned value
        if value1 != nil && value2 !=nil
          if value1 < value2
            memory_store << value1
            memory_store << value2
          else
            memory_store << value2
            memory_store << value1
          end 
        elsif value1 != nil
          memory_store << value1
        else
          memory_store << value2
        end 

        if memory_store.count == memory_size
          output << memory_store
          memory_store = []
        end

        # clear empty arrays
        array.shift if array[0].empty?
        array.shift if array[0].empty?

      end

      if array.empty?
        p output
        array = output
      else
        output << array.shift
        array = output
      end
    
      array.flatten!
      pass += 1
      p array
    end

  p "**** sorting complete! ****"
  p array
  
  end

  def sort_check(array)
    runner1 = 1
    runner2 = 0
    while runner1 < array.length
      if array[runner1] > array[runner2]
        runner1 += 1 
        runner2 += 1 
        # p "#{runner1} #{runner2}"
      else
        return false
      end
    end
    return true
  end
end


# ### Sample Output:
# (1...89).to_a.shuffle
array = [39, 49, 84, 74, 10, 54, 42, 69, 59, 4, 26, 60, 78, 15, 25, 46, 86, 50, 77, 12, 45, 79, 41, 18, 8, 81, 65, 16, 68, 70, 76, 2, 13, 88, 21, 5, 3, 30, 19, 33, 28, 66, 40, 72, 31, 58, 7, 61, 22, 57, 34, 24, 17, 44, 47, 36, 43, 37, 75, 9, 38, 73, 23, 14, 53, 87, 80, 35, 51, 85, 48, 83, 52, 64, 56, 11, 82, 62, 1, 32, 20, 29, 27, 63, 6, 71, 67, 55]

Sort.external_sort(array, 8)
# => [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88]


# ### Additional Resources:
# https://en.wikipedia.org/wiki/External_sorting
# http://faculty.simpson.edu/lydia.sinapova/www/cmsc250/LN250_Weiss/L17-ExternalSortEX1.htm
# http://faculty.simpson.edu/lydia.sinapova/www/cmsc250/LN250_Weiss/L17-ExternalSortEX2.htm
