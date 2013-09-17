require 'debugger'

students = [:oddalot,
            :persamina,
            :djquan,
            :RussHR,
            :jsrosen3,
            :amtrakcn,
            "giant-squid",
            :jsinghdreams,
            :atseng3,
            :justalisteningman,
            :Zehhu,
            :bwarkee,
            :aarnwri,
            :guillewu,
            :dyang12,
            :izhou,
            :vpark,
            :tnd23 ]

def pair students
  return [students] if students.length == 2

  middle = students.length/2
  left = students[0...middle]
  right = students[middle..-1]

  days = []
  (left.length).times do
    days << left.rotate!.zip(right)
  end

  left_days = pair(left)
  right_days = pair(right)

  days
end

def itr_pair students
  previous_pairs = []
  combos = students.combination(2).to_a
  days = { 0=>[] }

  until combos.empty?
    pair = combos.shift

    i = 0
    while days[i].flatten.include?(pair[0]) || days[i].flatten.include?(pair[1])
      i += 1
    end

    days[i] << pair

    i += 1
    days[i] ||= Array.new
  end
  days
end

d = itr_pair students
p d.values.flatten(1).uniq.count

p "#{ d.count } days worth of pairs for #{ students.length } students."




