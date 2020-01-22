def ceaser_cipher(string, shift)
  lowercase_letters = ("a".."z").to_a
  uppercase_letters = ("A".."Z").to_a
  new_string = ""
  string.each_char do |letter|
    index = lowercase_letters.index(letter)
    if index
      if lowercase_letters[index + shift.to_i]
        new_string << lowercase_letters[index + shift.to_i]
        next
      end
      new_string << lowercase_letters[(index + shift.to_i) - 26]
       next
    end
    index = uppercase_letters.index(letter)
    if index
      if uppercase_letters[index + shift.to_i]
        new_string << uppercase_letters[index + shift.to_i]
        next
      end
      new_string << uppercase_letters[(index + shift.to_i) - 26]
      next
    end
    new_string << letter
  end
  new_string
end

puts ceaser_cipher("What a string!", 5)