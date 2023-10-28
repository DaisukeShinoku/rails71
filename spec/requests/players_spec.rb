require "rails_helper"

RSpec.describe "Players", type: :request do
  describe "GET /index" do
    let(:teams) { create_list(:team, 3) }
    before do
      teams.map do |team|
        create_list(:player, 3, team:)
      end
    end
    it "正しくresponseが返ること" do
      get players_url
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    let(:team) { create(:team) }
    let(:player) { create(:player, team:) }
    it "正しくresponseが返ること" do
      get team_player_url(team, player)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    let(:team) { create(:team) }
    it "正しくresponseが返ること" do
      get new_team_player_url(team)
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    let(:team) { create(:team) }
    it "選手登録に成功し選手詳細画面へと遷移する" do
      player_attributes = attributes_for(:player, team_id: team.id)

      expect do
        post team_players_url(team), params: player_attributes
        expect(response).to redirect_to(team_player_url(team, Player.last)).and
        change(Player, :count).by(1)
      end
    end
  end
end
