# ### Problem:
# Imagine you have a call center with three levels of employees: respondent, manager, and director. An incoming telephone call must be first allocated to a respondent who is free. If the respondent can't handle the call, he or she must escalate the call to a manager. If the manager is not free or notable to handle it, then the call should be escalated to a director. Design the classes and data structures for this problem. Implement a method dispatchCall() which assigns a call to the first available employee.

# ### Assumptions:
# what does each type of employee do?
# how do I determine if they're busy or not?
# we're implementing an employee class as people held different titles but they're all employees of the company.
# I'm imaging this like a boolean gate, y/n then pass on to the next level. Are there additional assumptions I should be making? Are there more respondants > managers > directors?
# In addition are there differences in the percentage of chances they will pick up their calls?
# There are a few things which are common to them, like address, name, job title, and age. These things can be kept in one class and can be extended or inherited by others.
# Finally, there should be one CallHandler class which would route the calls to the correct person.
# Note that on any object-oriented design question, there are many ways to design the objects. Discuss the trade-offs of different solutions with your interviewer. You should usually design for long-term code flexibility and maintenance.
# what are the trade-offs between different implementations?

# ### Solution:
# CallHandler is implemented as a singleton class. It represents the body of the program, and all calls are funneled first through it.

class Employee
  attr_accessor :rank, :in_a_call

  def initialize(in_a_call=false)
    @in_a_call = in_a_call
    @rank = nil
  end

  def call_received
    @in_a_call = true
  end

  def update(call)
    @in_a_call = false
  end
end


class Respondent < Employee
  def initialize
    super
    @rank = 0
  end
end

class Manager < Employee
  def initialize
    super
    @rank = 1
  end
end

class Director < Employee
  def initialize
    super
    @rank = 2
  end
end


class CallHandler
  attr_accessor :employees, :call_que, :servicing_calls

  # Initialize 2 respondents, 1 managers, and 1 directors.
  def initialize(respondents=2, managers=1, directors=1)
    @call_que = []
    @servicing_calls = []

    @employees = []

    respondents.times { @employees << Respondent.new }
    managers.times { @employees << Manager.new }
    directors.times { @employees << Director.new }
  end

  def list_employees
    @employees
  end

  def incoming_call(name, rank=0)
    @call_que << Call.new(name)
    dispatch_call
  end

  def escalate_and_reassign(call)
    call.increase_rank
    dispatch_call
  end

  def update(call)
    puts "checking for waiting callers..." 
    dispatch_call 
  end

  def dispatch_call
    @call_que.empty? ? "there is currently no waiting caller" : @current_caller = @call_que.shift

    rank = @current_caller.rank 
    if rank == 0 && check_availability(0)
      match_call(0)
    elsif rank <= 1 && check_availability(1)
      match_call(1)
    elsif rank <= 2 && check_availability(2)
      match_call(2)
    else
      @call_que.unshift(@current_caller)
      "We're sorry, all personnels are busy at the moment thank you for your patience."\
      "Please stay on the line"\
    end
  end

  def check_availability(rank)
    @employees.find {|employee| employee.in_a_call == false && employee.rank == rank}
  end

  def match_call(rank)
    handler = @employees.find {|employee| employee.in_a_call == false && employee.rank == rank}
    handler.call_received
    @current_caller.add_observer(handler)
    @current_caller.add_observer(self)
    #passing self here contains way too much info that the @current_call doesn't need to know
    #but we'll leave this here for now as we want the CallHandler instance to be notified
    #when a call ended and to check for any waiting calls.
    @servicing_calls << @current_caller
  end
end


module Subject
  def initialize
    @observers=[]
  end

  def add_observer(observer)
    @observers << observer
  end

  def delete_observer(observer)
    @observers.delete(observer)
  end

  def notify_observers
    @observers.each do |observer|
      observer.update(self)
    end
  end
end

Caller = Struct.new(:name)

class Call
  include Subject
  attr_accessor :rank

  def initialize(name, rank=0)
    super()
    @rank = rank
    @caller = Caller.new(name)
  end

  def increase_rank
    if @rank != 2
      @rank += 1
    else
      @rank  
    end
  end

  def completed
    notify_observers
  end
end


# ### Sample Output:
callcenter = CallHandler.new
callcenter.list_employees
# => [#<Respondent:0x007fc6e29b0608 @in_a_call=false, @rank=0>, #<Respondent:0x007fc6e29b05e0 @in_a_call=false, @rank=0>, #<Manager:0x007fc6e29b05b8 @in_a_call=false, @rank=1>, #<Director:0x007fc6e29b0590 @in_a_call=false, @rank=2>]

# handling calls
callcenter.incoming_call("Scott")
# => [#<Call:0x007febca1b0108 @observers=[#<Respondent:0x007febca1b0540 @in_a_call=true, @rank=0>], @rank=0, @caller=#<struct Caller name="Scott">>]

callcenter.incoming_call("Stephanie")
callcenter.incoming_call("Steve")
callcenter.incoming_call("Stacy")
callcenter.incoming_call("Stan")
# => "We're sorry, all personnels are busy at the moment thank you for your patience.Please stay on the line"

callcenter.call_que
# => [#<Call:0x007f8ca3878c00 @observers=[], @rank=0, @caller=#<struct Caller name="Stan">>]

call = callcenter.servicing_calls[0]
# => #<Call:0x007fce391b8af0 @observers=[#<Respondent:0x007fce391b8bb8 @in_a_call=true, @rank=0>], @rank=0, @caller=#<struct Caller name="Scott">>

callcenter.escalate_and_reassign(call)
# => #<Call:0x007fd92b2a4ac0 @observers=[#<Respondent:0x007fd92b2a4b88 @in_a_call=true, @rank=0>], @rank=1, @caller=#<struct Caller name="Scott">>

call.completed
"checking for waiting callers..."

callcenter.call_que
#=> []


