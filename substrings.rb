def substrings words, dictionary
  words = words.split.map {|word| word.gsub(/[^0-9a-z ]/i, '').downcase}
  matches = Hash.new(0)
  words.each {|word|
    dictionary.each {|string|
      string.downcase!
      if word[string]
        matches[string] += 1
      end
    }
  }
  p matches
end

dictionary = ["below", "down", "go", "going", "horn", "how", "howdy", "it", "i", "low", "own", "part", "partner", "sit"]
substrings("below", dictionary)
substrings("Howdy partner, sit down! How's it going?", dictionary)