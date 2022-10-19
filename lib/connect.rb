# Represents a game of Connect Four
#
class ConnectFour

  NO_CHIP = 0
  P1_CHIP = 1
  P2_CHIP = 2

  attr_accessor :board

  # @param [Array] board
  # @param [Integer] board_size
  # @return void
  def initialize(board = nil, board_size = 6)
    if !board.nil?
      @board = board
    else
      @board = []
      (0...board_size).each do |x|
        @board << []
        (0...board_size).each do |y|
          @board[x][y] = NO_CHIP
        end
      end
    end
  end

  def print_board
    (0...@board.length).each do |x|
      row = [0...@board.length].map { |item| @board[x][item] }
      puts '|' << row.join('|') << "|\n"
    end
    puts '|-|-|-|-|-|-|'
    puts '|           |'
  end

  def drop_chip(player, column)
    @board.length.step(1, -1) do |y|
      if @board[y - 1][column - 1] == NO_CHIP
        @board[y - 1][column - 1] = player
        return @board
      end
    end
    raise 'No room in the column'
  end

  def take_turn(player)
    taken = false
    until taken
      puts "Enter a number from 1 to #{@board.length} for the column: "
      turn = gets.chomp
      column = Integer(turn, exception: false)
      unless column.nil?
        if column != 0 && column <= @board.length
          begin
            @board = drop_chip(player, column)
            taken = true
            return
          rescue RuntimeError
            puts 'There is no room in that column. Choose another'
          end
        else
          puts 'Cant convert that'
        end
      end
    end
  end

  # @param [Integer] player The player to check if they've won
  # @return [FalseClass, TrueClass]
  def winner?(player)
    # column check
    return true if column_check(player)
    # Row check
    return true if check_row(player)
    # Diagonal
    return true if check_diagonal(player)

    false
  end

  def play
    winner = false
    player = P2_CHIP
    begin
      player = if player == P1_CHIP
                 P2_CHIP
               else
                 P1_CHIP
               end

      take_turn(player)
      print_board
    end until winner?(player)
  end

  private

  def check_row(player)
    chip_count = 0
    (0...@board.length).each do |x|
      (0...@board.length).each do |y|
        if @board[x][y] == player
          chip_count += 1
        else
          chip_count = 0
        end

        return true if chip_count >= 4
      end
    end
    false
  end

  def check_diagonal(player)
    chip_count = 0
    (0...@board.length).each do |x_origin|
      (0...@board.length).each do |y_origin|
        x = x_origin
        y = y_origin
        while x < @board.length && y < @board.length
          if @board[x][y] == player
            chip_count += 1
          else
            chip_count = 0
          end

          x += 1
          y += 1

          return true if chip_count >= 4
        end

        chip_count = 0
        x = x_origin
        y = @board.length - 1
        while x < @board.length && y >= 0
          if @board[x][y] == player
            chip_count += 1
          else
            chip_count = 0
          end

          x += 1
          y -= 1
          return true if chip_count >= 4
        end
      end
    end
    chip_count >= 4
  end

  def column_check(player)
    chip_count = 0
    (0...@board.length).each do |y|
      (0...@board.length).each do |x|
        if @board[x][y] == player
          chip_count += 1
        else
          chip_count = 0
        end

        return true if chip_count >= 4
      end
    end
    false
  end
end
