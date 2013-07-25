def rpn
  nums_and_operands = []
  puts "start calculating using rpn notation:"

  input = gets.chomp.to_i
  raise "not a number " unless input.is_a?(Fixnum)

  nums_and_operands << input

  until input == 'q'
    p nums_and_operands
    input = gets.chomp
    if ['+', '-', '*', '/'].include?(input)
      nums_and_operands[-2] = nums_and_operands[-1].send(input.to_s, nums_and_operands[-2])
      nums_and_operands.pop
    else
      nums_and_operands << input.to_i
    end
    puts nums_and_operands.last
  end
end

rpn
