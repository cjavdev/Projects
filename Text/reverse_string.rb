class String
  def my_reverse
    reversed = []
    self.split(//).each do |letter|
      reversed.unshift(letter)
    end
    reversed.join
  end
end

p "testing".my_reverse
