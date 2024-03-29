class TeamsController < ApplicationController
  def index
    @teams = Team.all
  end

  def show
    @team = Team.find_by(id: params[:id])
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      redirect_to @team
    else
      render "new"
    end
  end

  private

  def team_params
    params.require(:team).permit(:name)
  end
end
