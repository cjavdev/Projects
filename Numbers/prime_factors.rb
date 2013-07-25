def prime_factors num
  prime_factors = []
  factors(num).each do |factor|
    prime_factors << factor if prime? factor
  end
  prime_factors
end

def prime? num
  factors(num).length <= 2
end

def factors num
  factors = []
  (1..num).each do |x|
    factors << x if num % x == 0
  end
  factors
end

p factors 1
p factors 3
p factors 9

p prime_factors 1
p prime_factors 10
p prime_factors 25
p prime_factors 49