class PlayersController < ApplicationController
  def index
    @players = Player.all
  end

  def show
    @player = Player.find_by(id: params[:id])
  end

  def new
    @team ||= Team.find_by(id: params[:team_id])
    @player = Player.new
  end

  def create
    @player = Player.new(player_params)
    @team = Team.find_by(id: params[:team_id])
    if @player.save
      redirect_to team_player_url(@team, @player)
    else
      render "new", { team: @team }
    end
  end

  def player_params
    params.require(:player).permit(:name, :team_id)
  end
end
