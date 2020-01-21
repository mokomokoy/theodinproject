def bubble_sort(arr)
    n = 0
    while n <= arr.length
        arr.each_with_index.map { |v, k|
            if k > 0 && (arr[k - 1] > arr[k])
                arr[k - 1], arr[k] = v, arr[k - 1]
            end
        }
        n += 1
    end
    p arr
end

bubble_sort([4,3,78,2,0,2,16,5])

def bubble_sort_by(arr)
    n = 0
    while n <= arr.length
        arr.each_with_index { |item, idx|
            if idx > 0 && yield(arr[idx - 1], item) > 0
                arr[idx - 1], arr[idx] = item, arr[idx - 1]
            end
        }
        n += 1
    end
    p arr
end

bubble_sort_by(["bonjour","namaste", "hi","hello","hey"]) do |left,right|
   left.length - right.length
end