module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?
    
    for i in self
      yield i
    end
    self
  end

  [1, 2, 3, 4].my_each do |item|
    puts item
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?
    i = 0
    for item in self
        yield item, i
        i += 0
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?
    new_arr = []
    my_each do |item|
        new_arr.push(item) if yield item
    end
    new_arr
      
  end

  def my_all?(argm = nil)
    to_a
    result = true
    if block_given? && !*argm
        my_each {|item| return false if yield(item) == false}
        return result
    elsif *argm.nil?
        my_each {|item| return false if item.nil? || item == false}
    elsif *argm.instance_of?(Class)
        my_each {|item| return false unless item.is_a?(*argm)}
        return result
    elsif *argm.instance_of?(Regexp)
        my_each {|item| return false unless *argm.match(|item|)}
    else
        my_each {|item| return false if |item| != *argm}
    end
    result
      
  end

  def my_any?(argm = nil)
    to_a
    result = true
    if block.given? 
      my_each {|item| return result if yield(item)}
      return false
    elsif argm.nil?
        my_each(|item| return result if item)
    elsif !argm.nil? && (argm.instance_of?(Class))
        my_each {|item| return result if item.is_a?(argm)}
    elsif !argm.nil? && (*argm.instance_of?(Regexp))
        my_each {|item| return result if argm.match(item)}
    else
        my_each {|item| return result if argm == item }
    end
    false
  end

  def my_none?
    return to_enum(my_none?) unless block_given?
    arr = self
    arr.my_each do |item|
      return false unless yield(item)
      true
    end
      
  end

  def count(argm)
    to_a
    if argm
      counted = self.my_select {|element| element == argm}
      counted.length
    else
      return self.length unless block_given?
      counter = 0
      my_each do |element|
        counter += 1 if yield(element)
      end
      counter
    end
    
    
  end

  def my_map(proc = nil)
    to_a
    return to_enum(:my_map) unless block_given? || !proc.nil?
    new_arr = []
    if proc.nil?
      self.my_each do |item|
        new_arr.push(yield(item))
      end
    else 
      self.my_each do |item|
        new_arr.push(proc.call(item))
      end
    end
    new_arr
  

  end
end

def my_inject()
  
end


    
    
  


    
end


