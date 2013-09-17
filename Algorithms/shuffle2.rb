require 'debugger'

class WorkDay
  attr_accessor :pairs

  def initialize pairs = []
    @pairs = pairs
  end

  def partial_pair? pair
    @pairs.flatten.include?(pair.first) || @pairs.flatten.include?(pair.last)
  end

  def pair student1, student2
    unless has_part_of_pair?([student1, student2])
      @pairs << [student1, student2]
    end
  end

  def has_pair? pair
    student1, student2 = pair
    @pairs.any? { |pair| pair.include?(student1) && pair.include?(student2) }
  end

  def pair_count
    @pairs.count
  end
end

class PodSession
  attr_accessor :work_days, :students

  def initialize( work_days = [], students = [] )
    @students = students
    @student_combos = @students.combination(2).to_a
    @work_days = work_days
    @freshness = 0
  end

  # returns number of times students have been paired together
  def pair_count pair
    count = 0
    @work_days.each do |work_day|
      count += 1 if work_day.has_pair?(pair)
    end
    count
  end

  def next_work_day rotating_pairs, static_pairs
    WorkDay.new(rotating_pairs.zip(static_pairs))
  end

  def gen_session
    mid = (@students.length / 2)
    @ranges = [(0...mid)]
    debugger
    until @ranges.first.to_a.count <= 1
      (Math.log2(@students.count).to_i + 1).times do
        @students.rotate_ranges! @ranges
        @work_days << WorkDay.new( @students.lside.zip(@students.rside) )
      end

      range_count = @ranges.count
      @ranges = [(0...mid/2)]
      (range_count * 2).times do |x|
        @ranges << (mid..(mid + mid/2))
      end
    end
  end
end

class Array
  def lside
    self[0...self.length/2]
  end

  def rside
    self[self.length/2..-1]
  end

  def rotate_ranges! ranges
    ranges.each do |range|
      self[range] = self[range].rotate
    end
  end
end

students = [:oddalot,
            :persamina,
            :djquan,
            :RussHR,
            :jsrosen3,
            # :amtrakcn,
            # "giant-squid",
            # :jsinghdreams,
            # :atseng3,
            # :justalisteningman,
            # :Zehhu,
            # :bwarkee,
            # :aarnwri,
            # :guillewu,
            # :dyang12,
            # :izhou,
            # :vpark,
            :tnd23 ]

sesh = PodSession.new([], students)
sesh.gen_session

p sesh.work_days
