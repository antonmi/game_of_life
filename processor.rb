class Processor

  def initialize(hash)
    @hash = hash
    @new_hash = {}
  end

  def next_gen!
    @hash.each_key { |key| process_cell(key) }
    @hash = @new_hash.dup
    @new_hash = {}
    @hash
  end

  def vizualize(xmax = 10, ymax = 10)
    (1..ymax).to_a.each do |y|
      str = ''
      (1..xmax).to_a.each do |x|
        str << (@hash[[x,y]] ? ' #' : ' .')
      end
      puts str
    end
  end

  def neigh_count(coords)
    count = 0
    proc = Proc.new do |dx, dy|
      next if (dx == 0) && (dy == 0)
      count += @hash[[coords.first + dx, coords.last + dy]].to_i
    end
    iterate_neighbours(proc)
    count
  end

  def alive?(coords)
    count = neigh_count(coords)
    result = 0
    result = @hash[coords] if count == 2
    result = 1 if count == 3
    result == 1
  end

  def process_cell(coords)
    proc = Proc.new do |dx, dy|
      if alive?([coords.first + dx, coords.last + dy])
        @new_hash[[coords.first + dx, coords.last + dy]] = 1
      end
    end
    iterate_neighbours(proc)
  end

  def iterate_neighbours(proc)
    (-1..1).to_a.each do |dx|
      (-1..1).to_a.each do |dy|
        proc.call(dx, dy)
      end
    end
  end

end
