class Game
  include ActiveModel::Model

  attr_reader :score, :frames, :playing_frame

  def initialize
    @score = 0
    @frames = []
    # adding the 10 frames
    FRAMES_NUMBER.times { @frames << Frame.new }
    @playing_frame = 0
  end

  def bowl(pins)
    unless over?
      scoring(pins)
      if spare?(pins) || strike?(pins)
        # if spare or strike, we move to next frame, unless it's the last frame
        if last_frame?
          current_frame.bonus! unless current_frame.bonus?
          current_frame.over? ? next_frame : current_frame.next!
        else
          next_frame
        end
      else
        if current_frame.over?
          # if current frame is over, move to the next frame
          next_frame
        else
          # else, move to next bowl into the frame
          current_frame.next!
        end
      end
    end
    @score
  end

  def over?
    @playing_frame == FRAMES_NUMBER
  end

  private

  def scoring(pins)
    current_frame.pins_left -= pins
    current_bowl.special = :spare if spare?(pins)
    current_bowl.special = :strike if strike?(pins)
    if previous_frame_special?(:spare) && current_frame.playing_bowl == 0
      @score += pins
    end
    if previous_frame_special?(:strike)
      @score += pins
      if previous_2_frame_strike?
        @score += pins
      end
    end
    @score += pins
  end

  def strike?(pins)
    if last_frame? # each try can be a strike in last frame
      if pins == PINS_NUMBER
        current_frame.pins_left = PINS_NUMBER
        return true
      end
    else
      pins == PINS_NUMBER && current_frame.playing_bowl == 0
    end
  end

  def spare?(pins)
    !strike?(pins) && current_frame.pins_left == 0
  end

  def next_frame
    @playing_frame += 1
  end

  def last_frame?
    @playing_frame == FRAMES_NUMBER - 1
  end

  def current_frame
    @frames[@playing_frame]
  end

  def current_bowl
    current_frame.bowls[current_frame.playing_bowl]
  end

  def previous_playing_frame(nb)
    @frames[@playing_frame - nb]
  end

  def previous_frame_special?(sym)
    if @playing_frame > 0
      case sym
        when :spare
          unless last_frame? && # last frame special case
              current_frame.playing_bowl > 1
            previous_playing_frame(1).bowls[1].special == sym # check previous frame spare
          end
        when :strike
          unless last_frame? && # last frame special case
              current_frame.playing_bowl > 1
            previous_playing_frame(1).bowls[0].special == sym # check previous frame strike
          end
        else
         false
      end
    end
  end

  def previous_2_frame_strike?
    unless last_frame? && # last frame special case
        current_frame.playing_bowl == 1
      previous_playing_frame(2).bowls[0].special == :strike
    end
  end
end
