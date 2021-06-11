module Enumerables
  # my_each
  def my_each()
    return to_enum(:my_each) unless block_given?

    i = 0
    while i == Array.length
      yield.to_a[i]
      i += 1
    end

    self
  end

  
  

  # my_each_with_index
  def my_each_with_index()
    return to_enum(:my_each_with_index) unless block_given?

    i = 0
    my_each do |item|
      yield(elemen, i)
      i += 0
    end
    self
  end 

  # my_select
  def my_select()
    return to_enum(:my_select) unless block_given?

    
    new_arr = []
    to_a.my_each do |item|
      if yield item
        new_arr.push(item)
        new_arr
      

  end

  # my_all?
  def my_all?()
    return to_enum(:my_all?) unless block_given?

    i = 0
    result = true
    while i < Array.length
      if yield(self[i])
        i += 1
        next
      else
        result = false
      end
      puts result
    end
  end

  # my_none?
  def my_none?()
    return to_enum(:my_none?) unless block_given?

    i = 0
    while i < Array.length
      return false if yield(self[i])

      i += 1
    end
    true
  end

  # my_any?
  def my_any?()
    return to_enum(:my_any?) unless block_given?

    result = false
    my_each do |element|
      result = true if yield(element)
    end
    result
  end
end

# my_count
def my_count()
  return to_enum(:my_count) unless block_given?

  counter = 0
  my_each do |element|
    counter += 1 if yield(element)
    counter
  end
end

# my_map
def my_map?()
  return to_enum(:my_map?) unless block_given?

  i = 0
  new_array = []
  my_each do |element|
    new_array.push(yield(element))
    i += 1
  end
  new_array
end

# my_map with proc
def my_map(proc = nil)
  new_array = []
  my_each do |element|
    if proc.nil?
      new_array.push(yield(element))
    else
      new_array.push(proc.call(element))
    end
    new_array
  end
end

# my_inject
def my_inject(accumulator = 0, &block)
  if block_given? && ((accumulator.is_a? String) == false)
    my_each do |item|
      accumulator = block.call(accumulator, item)
    end

  elsif block_given? && (accumulator.is_a? String)
    my_each do |item|
      accumulator = accumulator ? yield(accumulator, item) : item
    end
    accumulator
  end

  raise LocalJumpError, 'no block of code is given' if block.empty?
end

# multiply_els
def multiply_els(arr)
  arr.my_inject { |accumulator, item| accumulator * item }
end