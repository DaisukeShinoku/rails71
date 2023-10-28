require "rails_helper"

RSpec.describe "Teams", type: :system do
  before do
    driven_by(:rack_test)
  end

  scenario "チームを作成する" do
    visit teams_url
    click_link "参加チーム新規登録"
    fill_in "Name", with: "Newチーム"
    click_button "Create Team"
    expect(page).to have_text("Newチーム")
  end

  context "チーム一覧を表示する" do
    context "チームが存在する場合" do
      let!(:team1) { create(:team, name: "Indexチーム1") }
      let!(:team2) { create(:team, name: "Indexチーム2") }
      let!(:team3) { create(:team, name: "Indexチーム3") }

      scenario "チーム一覧が表示される" do
        visit teams_url
        aggregate_failures do
          expect(page).to have_selector "li", text: "Indexチーム1", exact_text: true
          expect(page).to have_selector "li", text: "Indexチーム2", exact_text: true
          expect(page).to have_selector "li", text: "Indexチーム3", exact_text: true
        end
      end
    end

    context "チームが存在しない場合" do
      scenario "チーム一覧が表示される" do
        visit teams_url
        expect(page).to have_selector "div", text: "チームが登録されていません。", exact_text: true
      end
    end
  end

  context "チーム詳細を表示する" do
    context "存在するチームの詳細を開いた場合" do
      let(:team) { create(:team, name: "showチーム") }

      scenario "チーム詳細が表示される" do
        visit team_url(team)
        expect(page).to have_selector "h1", text: "showチームの選手一覧", exact_text: true
      end
    end
  end
end
