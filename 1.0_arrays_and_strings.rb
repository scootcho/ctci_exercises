### Hash Tables
* A hash table is a data structure that maps keys to values for highly efficient lookup.
* hash table has an underlying array and a hash function.
* hash function maps the key to an integer, which indicates the index in the array. The object is then stored at that index. Arrays have predetermined sizes hence the memory needs to be reserved for the unallocated space when using arrays.
* hash value of all possible keys must be unique, or we might accidentally overwrite data. The array would have to be extremely large — the size of all possible keys — to prevent such "collisions."

![hashmap](http://i.stack.imgur.com/ySwxR.png)
http://stackoverflow.com/questions/10894558/how-hashtable-and-hashmap-key-value-are-stored-in-the-memory

#### Hashing
hash key -> hash function -> hash value -> retrieve from hash table

#### Hash Functions
Perfect Hash Function: map the same number of keys to each entry. (if we know the length of the number won't change)
Random Hash Funciton: each key is mapped to a random number between the given number. The problem is we won't be able to recall keys at random.

#### Pick a good hash function
make use of all info provided by key
uniformly distribute outputs across hash table
maps similar keys to very different hash values
uses very simple operations

#### Two ways to resolve collision:
Linear Probing (one of Open Addressing methods): insert into the next available slot upon collision. This introduces "clustering" as collision will likely to happen again around the same area on the table. O(N)
Separate Chaining. O(N/K) K is the size of the hash table

#### Methods to implement Hash Tables:
Linked List:
https://en.wikipedia.org/wiki/Hash_table#Separate_chaining_with_linked_lists
we can make the array much smaller by storing objects in a linked list. index hash(key) % array_length. The size of the list can be dynamically added will also require the search to traverse through the list. (This means on average we will find the element by traveling through half of the list)
To get the object with a particular key, we must search the linked list for this key.
The time for hash table operations is the time to find the bucket (which is constant) plus the time for the list operation.

Binary Search Tree:
https://en.wikipedia.org/wiki/Hash_table#Monotonic_keys
Alternatively, we can implement the hash table with a binary search tree. We can then guarantee an O(log n) lookup time, since we can keep the tree balanced.

The load factor (α): number of available keys / number of entries 
The load factor (α): The load factor is a measure of how full the hash table is


#### Differences between HashMap and Hashtable in Java
Hashtable is synchronized, whereas HashMap is not. This makes HashMap better for non-threaded applications, as unsynchronized Objects typically perform better than synchronized ones.

Hashtable does not allow null keys or values.  HashMap allows one null key and any number of null values.

One of HashMap's subclasses is LinkedHashMap, so in the event that you'd want predictable iteration order (which is insertion order by default), you could easily swap out the HashMap for a LinkedHashMap. This wouldn't be as easy if you were using Hashtable.

In Java, arrays internally use integers (int not Integer) for index, the max size is limited by the max size of integers. So theoretically it is 2^31-1 = 2147483647, which is Integer.MAX_VALUE.
https://www.quora.com/What-is-the-maximum-size-of-the-array-in-Java


####Ruby HashTable Implementation

```ruby
class RubyHash
  attr_reader :buckets

  def initialize
    @buckets = []
  end

  def assign_or_find_index(k)
    hash_function(k) % 1000 / 10 #divide by 10 because to_sym always have a 0 at the end. this can shrink the array size to 3 digits or max of 999 items
  end

  def hash_function(k)
    k = k.to_sym
    k.object_id
  end

  def insert(k, v)
    index = assign_or_find_index(k)
    buckets[index] ||= []
    buckets[index] << [k, v]
  end

  def find(k)
    index = assign_or_find_index(k)
    buckets[index].each do |k_v_pair|
      if k_v_pair[0] == k
        return k_v_pair[1]
      end
    end
  end

end
```

Note:
The `hash_function` uses `to_sym` as all symbols unique number:
```ruby
irb(main)> a = "hey".to_sym
=> :hey
irb(main)> a.object_id
=> 70279368579420
irb(main)> b = "hey".to_sym
=> :hey
irb(main)> b.object_id
=> 70279368579420
```

Another implementation using Struct

```
HashEntry = Struct.new(:key, :value)

class HashTable
  attr_accessor :bins
  attr_accessor :bin_count

  def initialize
    # Increase the bin number to reduce lookup times
    self.bin_count = 10000 #we're initializing an array that'll hold 9999 items
    self.bins = []
  end

  def insert(entry)
    index = bin_for(entry.key)
    self.bins[index] ||= []
    self.bins[index] << entry
  end

  #
  # Retrieve a HashEntry by looking for its key
  #
  def [](key)
    index = bin_for(key)
    self.bins[index].detect do |entry|
      entry.key == key
    end
  end

  #
  # Calculate the corresponding bin index
  # depending on the key's hash value.
  #
  def bin_for(key)
    key.hash % self.bin_count 
  end
end
```



#### ArrayList (Dynamically Resizing Array)
In Java the ArrayList class extends AbstractList and implements the List interface. ArrayList supports dynamic arrays that can grow as needed.

Standard Java arrays are of a fixed length. After arrays are created, they cannot grow or shrink, which means that you must know in advance how many elements an array will hold.


#### StringBuffer
Java's StringBuffer is a thread-safe, mutable sequence of characters. A string buffer is like a String, but can be modified. Every string buffer has a capacity. They are safe for use by multiple threads.

A good exercise to practice strings, arrays, and general data structures is to implement your own version of StringBuffer.

#### Bit Vector
https://en.wikipedia.org/wiki/Bit_array
A bit array is a mapping from some domain (almost always a range of integers) to values in the set {0, 1}.
know how to use Bit Array Data Structure


###Permutation

**Permutation** - the rearrangement of objects or symbols into distinguishable sequences. Each unique ordering is called a permutation.
Example:
How many ways to arrange the numbers [1,2,3].
6 different unique orders. 3 * 2 * 1 = 3!

**anagram**—two words with the same character count
Whenever we compare two strings, we know that if they are different lengths then they cannot be anagrams. 
Example:
"Clint Eastwood" is an anagram of "Old West Action"

**practice both implementing and using hash tables. They are one of the most common data structures for interviews.**


#### General knowledge:
ASCII has 0-255 characters (256 total)
Hexadecimal: 0-9, then A-F

---
#### Resources:
https://www.cs.cmu.edu/~tcortina/15-121sp10/Unit08B.pdf
http://stackoverflow.com/questions/10901752/what-is-the-significance-of-load-factor-in-hashmap
https://www.youtube.com/watch?v=h2d9b_nEzoA
http://stackoverflow.com/questions/40471/differences-between-hashmap-and-hashtable
https://en.wikipedia.org/wiki/Open_addressing
https://en.wikipedia.org/wiki/Hash_table
https://blog.engineyard.com/2013/hash-lookup-in-ruby-why-is-it-so-fast
http://sarahunderstandsverylittle.tumblr.com/post/80142286191/building-a-hash-table-in-ruby
https://github.com/gaylemcd/ctci/blob/master/ruby/lib/data-structures/hash-table/hash_table.rb
https://gist.github.com/dabit/5592821

