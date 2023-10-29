require "rails_helper"

RSpec.describe "Teams", type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:team) { create(:team, name: "Playerチーム") }

  scenario "選手を登録する" do
    visit team_url(team)
    click_link "新規選手登録"
    fill_in "Name", with: "New選手"
    click_button "Create Player"
    expect(page).to have_selector "p", text: "選手名: New選手", exact_text: true
  end

  context "選手一覧を表示する" do
    context "選手が存在する場合" do
      let!(:team1) { create(:team, name: "Indexチーム1") }
      let!(:team2) { create(:team, name: "Indexチーム2") }
      let!(:team3) { create(:team, name: "Indexチーム3") }
      let!(:player1) { create(:player, name: "Index選手1", team: team1) }
      let!(:player2) { create(:player, name: "Index選手2", team: team2) }
      let!(:player3) { create(:player, name: "Index選手3", team: team3) }

      scenario "選手一覧が表示される" do
        visit players_url
        expect(page).to have_selector "li", text: "Index選手1", exact_text: true
        expect(page).to have_selector "li", text: "Index選手2", exact_text: true
        expect(page).to have_selector "li", text: "Index選手3", exact_text: true
      end
    end

    context "選手が存在しない場合" do
      scenario "登録なしメッセージが表示される" do
        visit players_url
        expect(page).to have_selector "div", text: "選手が登録されていません。", exact_text: true
      end
    end
  end

  context "チーム内選手一覧を表示する" do
    context "選手が存在する場合" do
      let!(:team_player1) { create(:player, name: "TeamIndex選手1", team:) }
      let!(:team_player2) { create(:player, name: "TeamIndex選手2", team:) }
      let!(:team_player3) { create(:player, name: "TeamIndex選手3", team:) }

      scenario "選手一覧が表示される" do
        visit team_url(team)
        expect(page).to have_selector "li", text: "TeamIndex選手1", exact_text: true
        expect(page).to have_selector "li", text: "TeamIndex選手2", exact_text: true
        expect(page).to have_selector "li", text: "TeamIndex選手3", exact_text: true
      end
    end

    context "選手が存在しない場合" do
      scenario "登録なしメッセージが表示される" do
        visit team_url(team)
        expect(page).to have_selector "div", text: "選手が登録されていません。", exact_text: true
      end
    end
  end

  context "選手詳細を表示する" do
    let!(:player) { create(:player, team:, name: "Show選手") }

    context "チーム詳細から遷移する" do
      scenario "選手詳細が表示される" do
        visit team_url(team)
        click_link "Show選手"
        expect(page).to have_selector "p", text: "選手名: Show選手", exact_text: true
      end
    end

    context "選手一覧から遷移する" do
      scenario "選手詳細が表示される" do
        visit players_url
        click_link "Show選手"
        expect(page).to have_selector "p", text: "選手名: Show選手", exact_text: true
      end
    end
  end

  scenario "一連のplayer操作を行う" do
    # チーム詳細ページに遷移する
    visit team_url(team)
    # 選手新規登録ページに遷移する
    click_link "新規選手登録"
    # 選手を新規登録する
    fill_in "Name", with: "System選手1"
    click_button "Create Player"
    expect(page).to have_selector "p", text: "選手名: System選手1", exact_text: true
    # チーム内の選手一覧ページに遷移する
    click_link "Playerチーム"
    expect(page).to have_selector "li", text: "System選手1", exact_text: true
    # 選手新規登録ページに遷移する
    click_link "新規選手登録"
    # 選手を新規登録する
    fill_in "Name", with: "System選手2"
    click_button "Create Player"
    expect(page).to have_selector "p", text: "選手名: System選手2", exact_text: true
    # チーム内選手一覧ページに遷移する
    click_link "Playerチーム"
    expect(page).to have_selector "li", text: "System選手1", exact_text: true
    expect(page).to have_selector "li", text: "System選手2", exact_text: true
    # 選手詳細ページに遷移する
    click_link "System選手2"
    expect(page).to have_selector "p", text: "選手名: System選手2", exact_text: true
    # 選手一覧ページに遷移する
    click_link "選手一覧"
    expect(page).to have_selector "li", text: "System選手1", exact_text: true
    expect(page).to have_selector "li", text: "System選手2", exact_text: true
  end
end
