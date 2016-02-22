class Bowl < Struct.new(:special); end
class Frame
  include ActiveModel::Model
  attr_accessor :pins_left, :bowls, :playing_bowl

  def initialize(bowls=[],playing_bowl=0,pins_left=PINS_NUMBER,bonus=false)
    @bowls = []
    if bowls == []
      @bowls = bowls
      2.times { @bowls << Bowl.new(:none) }
    else
      bowls.each do |b|
        @bowls << Bowl.new(b['special'].to_sym)
      end
    end
    @playing_bowl = playing_bowl
    @pins_left = pins_left
    @bonus = bonus
  end

  def over?
    if (@bowls.size == 3 && @playing_bowl > 1) ||
        (@bowls.size == 2 && @playing_bowl == 1) || @pins_left == 0
      true
    else
      false
    end
  end

  def next!
    @playing_bowl += 1
  end

  def bonus?
    @bonus
  end

  def bonus!
    @bonus = true
    @pins_left = PINS_NUMBER
    @bowls << Bowl.new(:none)
  end
end
