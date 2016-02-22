require 'rails_helper'

RSpec.describe Frame, type: :model do

  context "create new frame" do
    f = Frame.new

    it "is not over and no bonus" do
      expect(f.bonus?).to be(false)
      expect(f.over?).to be(false)
    end
  end

  context "create new frame" do
    f = Frame.new

    it "goes to next bowl" do
      f.next!
      expect(f.over?).to be(true)
    end
  end

  context "create new frame" do
    f = Frame.new

    it "adds a bonus" do
      f.bonus!
      expect(f.bonus?).to be(true)
    end
    it "has to play 2 times to be over" do
      expect(f.over?).to be(false)
      2.times { f .next! }
      expect(f.over?).to be(true)
    end
  end

end
