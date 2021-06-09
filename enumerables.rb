# rubocop:disable Metrics/ModuleLength

module Enumerables
# my_each
    def my_each
        return to_enum(:my_each) unless block_given?

        i = 0
        while i < self.length
            yield(self[i])
            i +=1
        end

        self
        
    end

# my_each_with_index
  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    i = 0
    while i < self.length
      yield(self[i], i)
      i += 1
    end
    self[i]
  end

# my_select
  def my_select
    return to_enum(:my_select) unless block_given?

    i = 0
    new_arr = []
    while i < self.length
      if yield(self[i])
        new_arr.push(self[i])
        i += 1
      end
      puts new_arr
    end
  end

# my_all?
  def my_all?
    return to_enum(:my_all?) unless block_given?

    i = 0
    result = true
    while i < self.length
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
    return to_enum(:my_none?) unless block_given?

    i = 0
    while i < self.length
      return false if yield(self[i])

      i += 1
    end
    true
  end

# my_any?
def my_any?
    return to_enum(:my_any?) unless block_given?

    result = false
    self.my_each do |element|
      result = true if yield(element)
    end
    result
    end
    
end

# my_count
def my_count
    return to_enum(:my_count) unless block_given?
    counter = 0
    self.my_each do |element|
      counter += 1 if yield(element)
    end
    counter
    end
end

# my_map
def my_map
    return to_enum(:my_map) unless block_given?

    i = 0
    new_array = []
    self.my_each do |element|
      new_array.push(yield(element))
      i += 1
    end
    new_array
end


# my_map with proc
def my_map_with_proc(proc = nil)
    return to_enum(:my_map_with_proc) unless block_given?

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
        end
    
        if block_given? && accumulator.is_a? String   
            my_each do |item|
                accumulator = accumulator ? yield(accumulator, item) : item
            end
        end

        if block.empty?
            raise LocalJumpError, 'no block of code is given'
        end
    accumulator
  end

# multiply_els
def multiply_els(_arr)
  arr.my_inject { |accumulator, item| accumulator * item }
end

# rubocop:enable Metrics/ModuleLength
