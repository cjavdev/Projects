def next_prime num
  while true
    puts "Want to see the next prime?"
    dummy = gets.chomp
    until factors(num).length == 2
      num += 1
    end
    puts num    
    num += 1
  end
end

def factors num
  factors = []
  (1..num).each do |x|
    factors << x if num % x == 0
  end
  factors
end

next_prime 1

