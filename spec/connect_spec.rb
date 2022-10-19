require 'rspec'
require 'connect'

describe ConnectFour do

  it 'can be initialized' do
    expect(subject).to be_an_instance_of(ConnectFour)
  end

  it 'has a default size of six' do
    expect(subject.board.length).to eql(6)
    expect(subject.board[0].length).to eql(6)
    expect(subject.board[5].length).to eql(6)
  end
end

describe 'ConnectFourOverrides' do
  let (:game) { ConnectFour.new(nil, 10) }

  it 'has a default size of six' do
    expect(game.board.length).to eql(10)
    expect(game.board[5].length).to eql(10)
  end
end

describe 'ConnectFourVerticalWins' do

  describe 'VerticalWinOne' do
    subject do
      ConnectFour.new [
        [0, 0, 0, 0, 0, 1],
        [0, 0, 0, 0, 0, 1],
        [0, 0, 0, 0, 0, 1],
        [0, 0, 0, 0, 0, 1],
        [0, 0, 0, 0, 0, 1],
        [0, 0, 0, 0, 0, 1]
      ]
    end

    it 'recognizes a player 1 vertical win' do
      expect(subject.winner?(1))
    end
  end

  describe 'VerticalWinTwo' do
    subject do
      ConnectFour.new [
        [0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0],
        [2, 0, 0, 0, 0, 0],
        [2, 0, 0, 0, 0, 1],
        [2, 0, 0, 0, 0, 1],
        [2, 0, 0, 0, 0, 1]
      ]
    end

    it 'recognizes a player 2 vertical win' do
      expect(subject.winner?(2)).to eql(true)
    end
  end

end

describe 'ConnectFourHorizontalWins' do
  board = [
    [0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0],
    [1, 1, 1, 1, 1, 1]
  ]
  let (:game) { ConnectFour.new board }
  it 'recognizes a player 1 vertical win' do
    expect(game.winner?(1)).to eql(true)
  end
end

describe 'ConnectFourDiagonalWins' do

  describe 'LeftToRightDiagonal' do
    subject do
      ConnectFour.new [
        [0, 0, 0, 0, 0, 1],
        [0, 0, 0, 0, 1, 0],
        [0, 0, 0, 1, 0, 0],
        [0, 0, 1, 0, 0, 0],
        [0, 1, 0, 0, 0, 0],
        [1, 0, 0, 0, 0, 0]
      ]
    end
    let (:game) { ConnectFour.new board }
    it 'recognizes a player 1 left-to-right diagonal win' do
      expect(subject.winner?(1)).to eql(true)
    end
  end

  describe 'RightToLeftDiagonal' do
    subject do
      ConnectFour.new [
        [1, 0, 0, 0, 0, 0],
        [0, 1, 0, 0, 0, 0],
        [0, 0, 1, 0, 0, 0],
        [0, 0, 0, 1, 0, 0],
        [0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0]
      ]
    end
    let (:game) { ConnectFour.new board }
    it 'recognizes a player 1 left-to-right diagonal win' do
      expect(subject.winner?(1)).to eql(true)
    end
  end

  describe 'RightToLeftMidDiagonal' do
    subject do
      ConnectFour.new [
        [0, 0, 0, 0, 0, 0],
        [0, 1, 0, 0, 0, 0],
        [0, 0, 1, 0, 0, 0],
        [0, 0, 0, 1, 0, 0],
        [0, 0, 0, 0, 1, 0],
        [0, 0, 0, 0, 0, 0]
      ]
    end
    let (:game) { ConnectFour.new board }
    it 'recognizes a player 1 left-to-right diagonal win' do
      expect(subject.winner?(1)).to eql(true)
    end
  end
end

