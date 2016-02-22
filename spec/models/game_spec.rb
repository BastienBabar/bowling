require 'rails_helper'

RSpec.describe Game, type: :model do

  context "bowl first frame" do
    g = Game.new

    it "returns a score of 5" do
      g.bowl(5)
      expect(g.score).to eq(5)
    end
  end

  context "bowl the frames game" do
    g = Game.new

    it "returns the right score after frist frame is over" do
      g.bowl(5)
      g.bowl(4)
      expect(g.frames[0].over?).to be(true)
      expect(g.score).to eq(9)
    end
  end

  context "bowl the frames strike" do
    g = Game.new

    it "returns the right score with frist and second frame if first is strike" do
      g.bowl(10)
      expect(g.frames[0].over?).to be(true)
      g.bowl(4)
      g.bowl(3)
      expect(g.score).to eq(24)
    end
  end

  context "bowl the frames game" do
    g = Game.new

    it "plays an entire game" do
      10.times do
        g.bowl(5)
        g.bowl(4)
      end
      expect(g.over?).to be(true)
      expect(g.score).to eq(90)
    end
  end

  context "bowl the frames game with 3 strikes in last frame" do
    g = Game.new

    it "plays an entire game" do
      7.times do
        g.bowl(5)
        g.bowl(4)
      end #63
      g.bowl(10) #10 + 5 + 3 = 81
      g.bowl(5) #86
      g.bowl(3) #89
      g.bowl(10) #99
      g.bowl(10) #109
      g.bowl(10) #119
      expect(g.over?).to be(true)
      expect(g.score).to eq(119)
    end
  end

  context "bowl the frames game with spare in last frame" do
    g = Game.new

    it "plays an entire game" do
      7.times do
        g.bowl(5)
        g.bowl(4)
      end #63
      g.bowl(9) #72
      g.bowl(1) #1 + 4 = 77
      g.bowl(4) #81
      g.bowl(2) #83
      g.bowl(6) #89
      g.bowl(4) #93
      g.bowl(5) #98
      expect(g.over?).to be(true)
      expect(g.score).to eq(98)
    end
  end

  context "bowl the frames game with spare in 8th frame" do
    g = Game.new

    it "plays an entire game" do
      7.times do
        g.bowl(5)
        g.bowl(4)
      end #63
      g.bowl(9) #72
      g.bowl(1) #1 + 4 = 77
      g.bowl(4) #81
      g.bowl(2) #83
      g.bowl(6) #89
      g.bowl(4) #93
      g.bowl(10) #103
      expect(g.over?).to be(true)
      expect(g.score).to eq(103)
    end
  end

  context "bowl the frames game with spare and no bonus in last frame" do
    g = Game.new

    it "plays an entire game" do
      7.times do
        g.bowl(5)
        g.bowl(4)
      end #63
      g.bowl(9) #72
      g.bowl(1) #1 + 4 = 77
      g.bowl(4) #81
      g.bowl(2) #83
      g.bowl(5) #88
      g.bowl(4) #92
      expect(g.over?).to be(true)
      expect(g.score).to eq(92)
    end
  end

  context "bowl the frames game with spares and strikes" do
    g = Game.new

    it "plays an entire game" do
      6.times do
        g.bowl(5)
        g.bowl(4)
      end #54
      g.bowl(10) #64 + 9 + 1 = 74
      g.bowl(9) #83
      g.bowl(1) #1 + 4 = 88
      g.bowl(4) #92
      g.bowl(2) #94
      g.bowl(5) #99
      g.bowl(4) #103
      expect(g.over?).to be(true)
      expect(g.score).to eq(103)
    end
  end

  context "bowl the frames game with only strikes" do
    g = Game.new

    it "plays an entire game returns 300" do
      12.times do
        g.bowl(10)
      end #300
      expect(g.over?).to be(true)
      expect(g.score).to eq(300)
    end
  end

  context "bowl the frames game with strikes and spares in last frame" do
    g = Game.new

    it "plays an entire game returns 284" do
      9.times do
        g.bowl(10)
      end #250 + 10 + 4
      g.bowl(10) #274
      g.bowl(4) #278
      g.bowl(6) #284
      expect(g.over?).to be(true)
      expect(g.score).to eq(284)
    end
  end

  context "bowl the game with strike and spare in last frame" do
    g = Game.new

    it "plays an entire game returns 274" do
      9.times do
        g.bowl(10)
      end
      #220 + 10 + 4 = 234
      #244 + 4 + 6 = 254
      g.bowl(4) #258
      g.bowl(6) #264
      g.bowl(10) #274
      expect(g.over?).to be(true)
      expect(g.score).to eq(274)
    end
  end

  context "bowl the game with spare in 9th frame" do
    g = Game.new

    it "plays an entire game returns 264" do
      8.times do
        g.bowl(10)
      end #220 + 3 + 7 = 230
      g.bowl(3) #233
      g.bowl(7) #240 + 4 = 244
      g.bowl(4) #248
      g.bowl(6) #254
      g.bowl(10) #264
      expect(g.over?).to be(true)
      expect(g.score).to eq(264)
    end
  end

end
