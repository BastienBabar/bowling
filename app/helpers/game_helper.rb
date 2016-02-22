module GameHelper
  def strike?
    @game.strike?(params_bowling[:pins].to_i)
  end

  private
  def params_bowling
    params.permit(:pins)
  end
end
