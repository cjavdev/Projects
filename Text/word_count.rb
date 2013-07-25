def word_count sentence
  sentence.split(/ /).length
end

p word_count "this has 4 words"
p word_count "one"
p word_count "two words"
