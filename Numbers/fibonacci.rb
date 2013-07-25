def fibonacci(n)
  return [] if n <= 0
  return [1] if n == 1
  return [1, 1] if n == 2
  previous = fibonacci(n-1)
  return previous << previous[-2] + previous[-1]
end

p fibonacci(10)