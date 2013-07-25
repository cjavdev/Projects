VOWELS = ['a','e','i','o','u']
def count_vowels string
  count = 0
  string.split(//).each do |letter|
    count += 1 if VOWELS.include? letter
  end
  count
end

p count_vowels "testing"