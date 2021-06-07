# rubocop:disable Style/GuardClause
# rubocop:disable Style/RedundantSelf
# rubocop:disable Lint/DuplicateBranch

module Enumerables

    # my_each
    def my_each
        i = 0
        while i < self.length
            yield self
            i += 1
        end
        self[0]
    end

    # my_each_with_index
    def my_each_with_index
        i = 0
        while i < self.length
            yield(self[i], i)
            i += 1
        end
        self[i]
    end

    # my_select
    def my_select
        i = 0
        new_arr = []
        while i < self.length
        if yield(self[i])
            new_arr.push(self[i])
            i += 1
        end
        puts new_arr
    end

    #my_all?
    def my_all?
        i = 0
        result = true
        while i < self.length
            if yield(self[i])
                i +=1
                next
            else
                result = false
            end
            puts result
        end

    #my_none?
    def my_none?
        i = 0
        while  i < self.length
            if yield(self[i])
                return false
            end
            i += 1
        end
        true 
    end

    #my_any?
    def my_any?
        result = false
        self.my_each do |x|
            if yield(x)
                result = true
            end
            result 
        end

    #my_count
    def my_count
        counter = 0
        self.my_each do |x|
            counter += 1 if yield(x)
        end
        counter
    end

    #my_map
    def my_map 
        i = 0
        new_array = []
        self.my_each do |x|
            new_array.push(yield(x))
            i += 1
        end
        new_array
    end

    #my_map with proc (only proc would run if given block or proc as argument parameters)
    def my_map(proc = nil)
        new_array = []
        self.my_each do |x|
            unless proc.nil?
                new_array.push(proc.call(x))
            else
                new_array.push(yield(x))
            end
        end
        new_array
    end

    #my_inject
    def my_inject(accumulator = 0, &block)
        self.each do |item|
            accumulator = block.call(accumulator, item)
        end
        accumulator
    end

    #multiply_els
    def multiply_els(arr)
        self.my_inject {|accumulator, item| accumulator*item}
    end

# rubocop:enable Style/GuardClause
# rubocop:enable Style/RedundantSelf
# rubocop:enable Lint/DuplicateBranch
