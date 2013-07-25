def make_change amount, coins = [25, 10, 5, 1]
  return [] if amount == 0

  change = []
  until amount < coins.first
    change << coins[0]
    amount -= coins[0]
  end
  coins.shift
  change + make_change( amount, coins )
end

p make_change 87
