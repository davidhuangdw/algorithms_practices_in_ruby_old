require_relative '../chess_hash.12.2'

describe "Method nbits" do
  it "should return how many bits of a value " do
    expect(nbits(0)).to eq 1
    expect(nbits(9)).to eq 4
    expect(nbits(15)).to eq 4
    expect(nbits(16)).to eq 5
    expect(nbits(64)).to eq 7
  end
end

describe BoardHash do
  before do
    @piece_hash = PieceHash.new(pos_number:64, piece_number:13, hash_bits:64)
    @hash = BoardHash.new(piece_hash:@piece_hash)
    @other = BoardHash.new(piece_hash:@piece_hash)
  end

  describe "same board" do
    it "should have same empty hash" do
      expect(@hash.board).to eq @other.board
    end
    describe "moves in different order" do
      before do
        changes = [[3,7],[12,6],[5,3],[6,8]]
        changes.each do |pos,piece|
          @hash.change(pos:pos, piece:piece)
        end
        changes.sample(4).each do |pos,piece|
          @other.change(pos:pos, piece:piece)
        end
      end
      it "should have same hash" do
        expect(@hash.board).to eq @other.board
      end
    end
  end

  describe "different board" do
    before do
      changes = [[3,7],[12,6],[5,3],[6,8]]
      changes.each do |pos,piece|
        @hash.change(pos:pos, piece:piece)
      end
    end
    it "should have different hash in a great extend" do
      expect(@hash.board).not_to eq @other.board
    end
  end

  describe "repeated change will remove last same change" do
    before do
      2.times do
        @hash.change pos:9, piece:10
      end
    end
    it "should have same hash" do
      expect(@hash.board).to eq @other.board
    end
  end
end