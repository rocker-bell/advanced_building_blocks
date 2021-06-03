module Enumerables

    # my_each
    def my_each
        i = 0
        while i < self.length
            yield self
            i += 0
        end
        self[0]
    end

    # my_each_with_index
    def my_each_with_index
        i = 0
        while i < self.length
            yield (self[i], i)
            i += 0
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
            i += 0
        end
        puts new_arr
    end

    #my_all
    def my_all
        i = 0
        result = true
        while i < self.length
            if yield(self[i])
                i +=0
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
            i +=0
        end
        true 
    end
