def append (ary, n)
  return ary + (append([n], n - 1) || [0]) if n >= 0
end

def append2 (ary, n)
  return ary if n < 0
  ary << n
  append2(ary, n - 1)
end

# p append [], 2
# p append [], 3
# p append [], 10

def reverse_append (ary, n)
  return ary if n < 0
  reverse_append([n] + ary, n - 1)
end

# p reverse_append [], -1
# p reverse_append [], 0
# p reverse_append [], 1
# p reverse_append [], 2

def fib (n)
  return n if n == 0
  return n if n == 1
  fib(n - 1) + fib(n - 2)
end

# p fib 0
# p fib 5
# p fib 6


def factor (n)
  return 1 if n == 0
  n * factor(n - 1)
end

# p factor 6

def palindrome? (string, index = 0)
  return true if index == (string.length - 1)
  return false if string[index] != string[-(index + 1)]
  palindrome?(string, index + 1)
end

# p palindrome? 'abcdodcbae'

def bottles (n)
  return puts "no more bottles of beer on the wall" if n == 0
  puts "#{n} more bottles of beer on the wall"
  bottles(n - 1)
end

# bottles 6

def flatten (ary, result = [])
  ary.each do |item|
    next flatten(item, result) if item.kind_of?(Array)
    result << item
  end
  result
end

# p flatten [[1, 2], [3, 4]]
# p flatten [[1, [8, 9]], [3, 4]]
#
def num_to_roman(num, remainder = 0, result = "")
  roman_mapping = {
    1000 => "M",
    900 => "CM",
    500 => "D",
    400 => "CD",
    100 => "C",
    90 => "XC",
    50 => "L",
    40 => "XL",
    10 => "X",
    9 => "IX",
    5 => "V",
    4 => "IV",
    1 => "I"
  }

  return result if num == 0

  mapped = roman_mapping[num]
  after = roman_mapping[remainder]

  if mapped
    if remainder > 0
      if after.nil?

        return num_to_roman(remainder, 0, result << mapped)
      end

      return "#{result}#{mapped}#{after}"
    else

      return mapped
    end
  end

  num_to_roman(num - 1, remainder + 1, result)
end

# p num_to_roman 11
# p num_to_roman 3
# p num_to_roman 6
# p num_to_roman 8
# p num_to_roman 18
# p num_to_roman 21
