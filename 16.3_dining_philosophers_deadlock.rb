# ### Problem:
# In the famous dining philosophers problem, a bunch of philosophers are sitting around a circular table with one chopstick between each of them. A philosopher needs both chopsticks to eat, and always picks up the left chopstick before the right one. A deadlock could potentially occur if all the philosophers reached for the left chopstick at the same time. Using threads and locks, implement a simulation of the dining philosophers problem that prevents deadlocks.

# Clarifications:
# originally formulated in 1965 by Edsger Dijkstra used in concurrent algorithm design to illustrate synchronization issues and techniques for resolving them.

# ### Solution:
# source: https://practicingruby.com/articles/gentle-intro-to-actor-based-concurrency

class Chopstick
  def initialize
    @mutex = Mutex.new  # mutex that will ensure that two philosophers can not grab the same chopstick at the same time
  end

  def take
    @mutex.lock
  end

  def drop
    @mutex.unlock

  rescue ThreadError
    puts "Trying to drop a chopstick not acquired"
  end

  def in_use?
    @mutex.locked?
  end
end

class Table
  def initialize(num_seats)
    @chopsticks  = num_seats.times.map { Chopstick.new }
  end

  def left_chopstick_at(position)
    index = (position - 1) % @chopsticks.size
    @chopsticks[index]
  end

  def right_chopstick_at(position)
    index = position % @chopsticks.size
    @chopsticks[index]
  end

  def chopsticks_in_use
    @chopsticks.select { |f| f.in_use? }.size
  end
end

# Philosopher class that isn't threadsafe
# consider what happens when each philosopher object is given its own thread
# it is possible to reach a state in which every philosopher picks up their left-hand chopstick, resulting in a deadlock.
class Philosopher
  def initialize(name)
    @name = name
  end

  def dine(table, position)
    @left_chopstick  = table.left_chopstick_at(position)
    @right_chopstick = table.right_chopstick_at(position)

    loop do
      think
      eat
    end
  end

  def think
    puts "#{@name} is thinking"
  end

  def eat
    take_chopsticks

    puts "#{@name} is eating."

    drop_chopsticks
  end

  def take_chopsticks
    @left_chopstick.take
    @right_chopstick.take
  end

  def drop_chopsticks
    @left_chopstick.drop
    @right_chopstick.drop
  end
end

# using Waiter class and Mutex to mitigate deadlock condition.
class Waiter
  def initialize(capacity)
    @capacity = capacity
    @mutex    = Mutex.new
  end

  def serve(table, philosopher)
    @mutex.synchronize do   # Mutex's synchronize method coordinate access to shared data from multiple concurrent threads.
      sleep(rand) while table.chopsticks_in_use >= @capacity 
      philosopher.take_chopsticks
    end

    philosopher.eat
  end
end


class Philosopher

  # ... all omitted code same as before

  def dine(table, position, waiter)
    @left_chopstick  = table.left_chopstick_at(position)
    @right_chopstick = table.right_chopstick_at(position)

    loop do
      think

      # instead of calling eat() directly, make a request to the waiter 
      waiter.serve(table, self)
    end
  end

  def eat
    # removed take_chopsticks call, as that's now handled by the waiter

    puts "#{@name} is eating."

    drop_chopsticks

    puts "#{@name} is full."
  end
end


# ### Sample Output:
# ## output with without Waiter class:
# names = %w{Heraclitus Aristotle Epictetus Schopenhauer Popper}
# philosophers = names.map { |name| Philosopher.new(name) }
# table        = Table.new(philosophers.size)

# threads = philosophers.map.with_index do |philosopher, i|
#   Thread.new { philosopher.dine(table, i) }
# end

# threads.each(&:join)
# sleep

# =>
# Heraclitus is thinking
# Popper is eating.
# Popper is thinking
# Schopenhauer is eating.
# Schopenhauer is thinking
# Schopenhauer is eating.
# Schopenhauer is thinking
# Epictetus is eating.
# Epictetus is thinking
# Epictetus is eating.
# Epictetus is thinking
# 16.3_dining_philosophers_deadlock.rb:98:in `join': No live threads left. Deadlock? (fatal)
#   from 16.3_dining_philosophers_deadlock.rb:98:in `each'
#   from 16.3_dining_philosophers_deadlock.rb:98:in `<main>'

# ## output with without Waiter class:
names = %w{Heraclitus Aristotle Epictetus Schopenhauer Popper}
philosophers = names.map { |name| Philosopher.new(name) }
table  = Table.new(philosophers.size)
waiter = Waiter.new(philosophers.size - 1)

threads = philosophers.map.with_index do |philosopher, i|
  Thread.new { philosopher.dine(table, i, waiter) }
end

threads.each(&:join)
sleep

# => 
# Popper is thinking
# Schopenhauer is eating.
# Schopenhauer is full.
# Schopenhauer is thinking
# Heraclitus is eating.
# Heraclitus is full.
# ...


# ### Additional Resources:
# https://gist.github.com/egonSchiele/5565009
# https://github.com/mikeweber/Dining-Philosopherso
# http://rosettacode.org/wiki/Dining_philosophers
# https://practicingruby.com/articles/gentle-intro-to-actor-based-concurrency
