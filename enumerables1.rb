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

  def my_all?(*args = nil)
    to_a
    result = true
    if block_given? && !*args
        my_each {|item| return false if yield(item) == false}
        return result
    elsif *args.nil?
        my_each {|item| return false if item.nil? || item == false}
    elsif *args.instance_of?(Class)
        my_each {|item| return false unless item.is_a?(*args)}
        return result
    elsif *args.instance_of?(Regexp)
        my_each {|item| return false unless *args.match(|item|)}
    else
        my_each {|item| return false if |item| != *args}
    end
    result
      
  end

  def my_any?(*args = nil)
    to_a
    result = true
    if block.given? 
      my_each {|item| return result if yield(item)}
      return false
    elsif args.nil?
        my_each(|item| return result if item)
    elsif !args.nil? && (args.instance_of?(Class))
        my_each {|item| return result if item.is_a?(args)}
    elsif !args.nil? && (*args.instance_of?(Regexp))
        my_each {|item| return result if args.match(item)}
    else
        my_each {|item| return result if args == item }
    end
    false
  end

  def my_none?(*args= nil )
      
  end

  def count(*args)
    to_a
    if args
      counted = self.my_select {|element| element == args}
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


    
end


