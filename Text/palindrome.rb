def palindrome? string
  return true if string.length == 1
  return false if string[0] != string[-1]
  palindrome? string[1...-1]
end

p palindrome? "mom"
p palindrome? "notapalindrome"
p palindrome? "racecar"
