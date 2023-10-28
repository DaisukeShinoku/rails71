require "rails_helper"

RSpec.describe "Teams", type: :request do
  describe "GET /index" do
    let!(:teams) { create_list(:team, 3) }
    it "正しくresponseが返ること" do
      get players_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    let(:team) { create(:team) }
    it "正しくresponseが返ること" do
      get team_url(team)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "正しくresponseが返ること" do
      get new_team_url
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "チーム登録に成功しチーム詳細画面へと遷移する" do
      team_attributes = attributes_for(:team)

      expect do
        post team_url(team), params: team_attributes
        expect(response).to redirect_to(team_url(team)).and
        change(Team, :count).by(1)
      end
    end
  end
end
