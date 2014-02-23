FILENAME = 'data'
EMPTY = '*'
FULL = '@'

def read_file
  content = File.read(FILENAME)
  lines = content.split("\n")
  return lines
end

def parse_file(lines)
  first_line = lines[0]
  size = first_line.split(' ')
  rows = size[0].to_i
  cols = size[1].to_i
  lines = lines[1..-1]
  return rows, cols, lines
end

def mark_empty(map, i, j)
  # converts a square of 3x3 around [i,j] to empty area
  (i-1..i+1).each do |k|
    (j-1..j+1).each do |l|
      begin
      if k < 0 or l < 0
        next
      end
      if map[k][l] == EMPTY
        next
      end
      if i == k and j == l
        next
      end
        map[k][l] = EMPTY
        mark_empty(map, k, l)
      rescue
        next
      end
    end
  end
end

counter = 0
rows, cols, map = parse_file read_file
(0...rows).each do |i|
  (0...cols).each do |j|
    if map[i][j] == EMPTY
      next
    end 
    counter += 1
    mark_empty(map, i, j)
  end
end
puts counter