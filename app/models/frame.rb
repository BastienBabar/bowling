class Bowl < Struct.new(:special); end
class Frame
  include ActiveModel::Model
  attr_accessor :pins_left, :bowls, :playing_bowl

  def initialize
    @bowls = []
    2.times { @bowls << Bowl.new(:none) }
    @playing_bowl = 0
    @pins_left = PINS_NUMBER
  end

  def over?
    @playing_bowl == @bowls.length - 1 || @pins_left == 0
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
