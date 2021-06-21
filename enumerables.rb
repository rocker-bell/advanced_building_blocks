# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity
module Enumerable
  def my_each(&block)
    return to_enum(:my_each) unless block_given?

    each(&block)
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    i = 0
    my_each do |item|
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
    if block_given? && !argm
      my_each { |item| return false if yield(item) == false }
      return result
    elsif argm.nil?
      my_each { |item| return false if item.nil? || item == false }
    elsif argm.instance_of?(Class)
      my_each { |item| return false unless item.is_a?(argm) }
      return result
    elsif argm.instance_of?(Regexp)
      my_each { |item| return false unless argm.match(item) }
    else
      my_each { |item| return false if item != argm }
    end
    result
  end

  def my_any?(argm = nil)
    to_a

    if block_given?
      my_each { |item| return true if yield(item) }
      return false
    elsif argm.nil?
      my_each { |item| return true if item }
    elsif !argm.nil? && argm.instance_of?(Class)
      my_each { |item| return true if item.is_a?(argm) }
    elsif !argm.nil? && argm.instance_of?(Regexp)
      my_each { |item| return true if argm.match(item) }
    else
      my_each { |item| return true if argm == item }
    end
    false
  end

  def my_none?
    return to_enum unless block_given?

    arr = self
    arr.my_each do |item|
      return false unless yield(item)

      true
    end
  end

  def my_count(argm)
    to_a
    if argm
      counted = my_select { |element| element == argm }
      counted.length
    else
      return length unless block_given?

      counter = 0
      my_each do |element|
        counter += 1 if yield(element)
      end
      counter
    end
  end

  def my_map(proc = nil)
    to_a
    return to_enum unless block_given? || !proc.nil?

    new_arr = []
    if proc.nil?
      my_each do |item|
        new_arr.push(yield(item))
      end
    else
      my_each do |item|
        new_arr.push(proc.call(item))
      end
    end
    new_arr
  end
end

def my_inject(accumulator = 0, &block)
  if block_given? && !accumulator.instance_of?(String)
    my_each do |item|
      accumulator = block.call(accumulator, item)
    end
  elsif block_given? && accumulator.instance_of?(String)
    my_each do |item|
      accumulator = accumulator ? yield(accumulator, item) : item
    end
    accumulator
  end
  raise LocalJumpError 'No block of code given' unless block_given?
end

def multiply_els(arr)
  arr.my_inject(1) { |accumulator, item| accumulator * item }
end

my_array = [1, 2, 3, 4]

my_array.my_all?(Numeric)
my_array.my_any?
my_array.my_none?
my_array.my_count(4)

multiply_els(my_array)

# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity
