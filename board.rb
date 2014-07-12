class Board
  attr_reader :state
  def initialize
    @table = Array.new(8)
    @table.map! do |line|
      Array.new(8,".")
    end
    @table[3][3] = "o"
    @table[3][4] = "x"
    @table[4][3] = "x"
    @table[4][4] = "o"
    @state = "x"
  end

  def out_of_table?(i, j)
    i < 0 || j < 0 || i >= 8 || j >= 8
  end

  def puttable?(i, j, state = @state)
    return false if out_of_table?(i, j)
    return false if @table[i][j] != "."
    di = [1,1,1,0,-1,-1,-1,0]
    dj = [1,0,-1,-1,-1,0,1,1]
    for k in 0...8
      for l in 1...8
        ni = i + di[k] * l
        nj = j + dj[k] * l
        break if out_of_table?(ni, nj)
        break if @table[ni][nj] == "."
        if @table[ni][nj] == state then
          if l > 1 then
            return true
          else
            break
          end
        end
      end
    end
    return false
  end

  def put(i, j)
    return if !puttable?(i, j)
    di = [1,1,1,0,-1,-1,-1,0]
    dj = [1,0,-1,-1,-1,0,1,1]
    for k in 0...8
      for l in 1...8
        ni = i + di[k] * l
        nj = j + dj[k] * l
        break if out_of_table?(ni, nj)
        break if @table[ni][nj] == "."
        if @table[ni][nj] == @state then
          for m in 1...l
            mi = i + di[k] * m
            mj = j + dj[k] * m
            @table[mi][mj] = @state
          end
          break
        end
      end
    end
    @table[i][j] = @state
    toggle
    if !puttable_some? then
      toggle
    end
  end

  def over?
    return !(puttable_some?("x") || puttable_some?("o"))
  end

  def puttable_some?(stone = @state)
    for i in 0...8
      for j in 0...8
        return true if puttable?(i, j, stone)
      end
    end
    return false
  end

  def to_s
    line_str = @table.map {|line| line.join("")} 
    line_str.join("\n")
  end

  private
  def toggle
    if @state == "x" then
      @state = "o"
    else
      @state = "x"
    end
  end
end
