class GameController < ApplicationController
  def bowling
    @game = Game.new
    session['game'] = @game.to_json
  end

  def bowl
    if session['game']
      json = JSON::load(session['game'])
      @game = Game.new(json['score'], json['frames'].to_a, json['playing_frame'])
    end
    unless @game.nil?
      @game.bowl(params_bowling[:pins].to_i)
    end
    session['game'] = @game.to_json
    respond_to do |format|
      format.js { render :layout => false }
    end
  end

  private
  def params_bowling
    params.permit(:pins)
  end
end
