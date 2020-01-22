module Enumerable
    def my_each
        for item in self
            yield(item)
            self
        end
    end

    def my_each_with_index
        for item in self
            if block_given?
                yield(item, self.index(item))
                return self
            end
        end
        to_enum(__method__)
    end

    def my_select
        new_arr = []
        self.my_each do |item|
            if yield(item)
                new_arr << item
            end
        end
        new_arr
    end

    def my_all?
        self.my_each do |item|
            if !yield(item)
                return false
            end
        end
        return true
    end

    def my_any?
        self.my_each do |item|
            if yield(item)
                return true
            end
        end
        return false
    end

    def my_none?
        self.my_each do |item|
            if yield(item)
                return false
            end
        end
        return true
    end

    def my_count(arg = false)
        if block_given?
            count = 0
            self.my_each do |item|
                if yield(item)
                    count += 1
                end
            end
            return count
        end
        if arg
            count = 0
            self.my_each do |item|
                if item == arg
                    count += 1
                end
            end
            return count
        end
        self.length
    end

    def my_map(&block)
       mapped = []
       self.my_each do |item|
           if !block.nil?
               mapped << block.call(item)
               next
           end
           mapped << yield(item)
       end
       mapped
    end

    def my_inject(args = [])
        if args.is_a? Symbol
            result = self.first
            for item in self.drop(1)
                result = result.send(args, item)
            end
            return result
        end
        result = self.first || nil
        for item in self.drop(1)
            result ||= item
            if block_given?
                result = yield(result, item)
            end
        end
        result
    end

end

#p [6, 7, 8].my_none? { |str| str == 9 }
#p [nil].any?

ary = [1, 2, 4, 2, 2]
#
# p ary.my_count
# p ary.my_count(2)
# p ary.my_count { |x| x%2 == 0 }
# p ary.my_map { |x| x.to_s + "!" }
p ary.my_inject { |sum, n| sum + n }
# [[:student, "Terrance Koar"], [:course, "Web Dev"]].my_inject({}) do |result, element|
#     result[element.first.to_s] = element.last.split
#     result
# end
def multiply_els(arr)
    arr.my_inject(:*)
end
p multiply_els([2, 4, 5])
