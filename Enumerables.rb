# rubocop disable: Metrics/MethodLength
# rubocop disable: Style/Documentation

module Enumerables
  # my_each
  def my_each
    i = 0
    while i < length
      yield self
      i += 1
    end
    self[0]
  end

  # my_each_with_index
  def my_each_with_index
    i = 0
    while i < length
      yield(self[i], i)
      i += 1
    end
    self[i]
  end

  # my_select
  def my_select
    return to_enum unless block_given?
    i = 0
    new_arr = []
    while i < length
      if yield(self[i])
        new_arr.push(self[i])
        i += 1
      end
      puts new_arr
    end
  end

  # my_all?
  def my_all?
    i = 0
    result = true
    while i < length
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
  def my_none?
    i = 0
    while i < length
      return false if yield(self[i])

      i += 1
    end
    true
  end

  # my_any?
  def my_any?
    result = false
    my_each do |x|
      result = true if yield(x)
      result
    end
  end

  # my_count
  def my_count
    counter = 0
    my_each do |x|
      counter += 1 if yield(x)
    end
    counter
  end

  # my_map
  def my_map
    i = 0
    new_array = []
    my_each do |x|
      new_array.push(yield(x))
      i += 1
    end
    new_array
  end

  # my_map with proc (only proc would run if given block or proc as argument parameters)
  def my_map_with_proc(proc = nil)
    new_array = []
    my_each do |x|
      if proc.nil?
        new_array.push(yield(x))
      else
        new_array.push(proc.call(x))
      end
    end
    new_array
  end

  # my_inject
  def my_inject(accumulator = 0, &block)
    if !block_given?
        raise LocalJumpError, "no block of code is given" if &block.empty?
    else
    each do |item|
      accumulator = block.call(accumulator, item)
    end
    accumulator
  end
end

# multiply_els
def multiply_els(_arr)
  my_inject { |accumulator, item| accumulator * item }
end

# rubocop enable: Metrics/MethodLength
# rubocop enable: Style/Documentation
