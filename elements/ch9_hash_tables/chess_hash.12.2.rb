def nbits(num=0)
  return 1 if num==0
  cnt = 0
  until num==0
    num >>= 1
    cnt += 1
  end
  cnt
end

class PieceHash
  attr_reader :pos_number, :piece_number
  def initialize(pos_number:nil, piece_number:nil, hash_bits:nil)
    raise SyntaxError unless pos_number && piece_number && hash_bits
    @pos_number=pos_number
    @piece_number = piece_number
    @nb = nbits(pos_number-1)
    @mod = 1<<hash_bits
    init_piece_hash
  end

  def piece_hash(pos:nil, piece:nil)
    @piece_hash[ind(pos:pos,piece:piece)]
  end

private
  def init_piece_hash
    @piece_hash = {}
    @pos_number.times do |pos|
      @piece_number.times do |piece|
        @piece_hash[ind(pos:pos,piece:piece)] = rand(@mod)
      end
    end
  end

  def ind(pos:nil, piece:nil)
    validate pos:pos, piece:piece
    (piece<<@nb) + pos
  end

  def validate(pos:nil, piece:nil)
    pos && pos>=0 && pos<@pos_number &&
        piece && piece>=0 && piece<@piece_number
  end
end

class BoardHash
  attr_reader :board_hash

  require 'forwardable'
  extend Forwardable
  def_delegators :@piece_hash, :piece_number, :pos_number, :piece_hash

  def initialize(piece_hash:nil)
    raise SyntaxError if piece_hash.nil?
    @piece_hash = piece_hash
    init_board
  end

  def change(pos:nil,piece:nil)
    @board_hash ^= piece_hash(pos:pos, piece:piece)
  end

  def board
    @board_hash
  end

private
  def init_board
    @board_hash = 0
    pos_number.times do |pos|
      change(pos:pos,piece:0)
    end
  end
end