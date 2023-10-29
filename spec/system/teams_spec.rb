require "rails_helper"

RSpec.describe "Teams", type: :system do
  before do
    driven_by(:rack_test)
  end

  scenario "チームを登録する" do
    visit teams_url
    click_link "参加チーム新規登録"
    fill_in "Name", with: "Newチーム"
    click_button "Create Team"
    expect(page).to have_selector "h1", text: "Newチームの選手一覧", exact_text: true
  end

  context "チーム一覧を表示する" do
    context "チームが存在する場合" do
      let!(:team1) { create(:team, name: "Indexチーム1") }
      let!(:team2) { create(:team, name: "Indexチーム2") }
      let!(:team3) { create(:team, name: "Indexチーム3") }

      scenario "チーム一覧が表示される" do
        visit teams_url
        expect(page).to have_selector "li", text: "Indexチーム1", exact_text: true
        expect(page).to have_selector "li", text: "Indexチーム2", exact_text: true
        expect(page).to have_selector "li", text: "Indexチーム3", exact_text: true
      end
    end

    context "チームが存在しない場合" do
      scenario "登録なしメッセージが表示される" do
        visit teams_url
        expect(page).to have_selector "div", text: "チームが登録されていません。", exact_text: true
      end
    end
  end

  context "チーム詳細を表示する" do
    let(:team) { create(:team, name: "showチーム") }

    scenario "チーム詳細が表示される" do
      visit team_url(team)
      expect(page).to have_selector "h1", text: "showチームの選手一覧", exact_text: true
      expect(page).to have_selector "div", text: "選手が登録されていません。", exact_text: true
    end
  end

  scenario "一連のteam操作を行う" do
    # チーム一覧ページに遷移する
    visit teams_url
    expect(page).to have_selector "div", text: "チームが登録されていません。", exact_text: true
    # チーム新規登録ページに遷移する
    click_link "参加チーム新規登録"
    # チームを新規登録する
    fill_in "Name", with: "Systemチーム1"
    click_button "Create Team"
    expect(page).to have_selector "h1", text: "Systemチーム1の選手一覧", exact_text: true
    # チーム一覧ページに遷移する
    click_link "別チームの情報を見る"
    expect(page).to have_selector "li", text: "Systemチーム1", exact_text: true
    # チームを新規登録する
    click_link "参加チーム新規登録"
    fill_in "Name", with: "Systemチーム2"
    click_button "Create Team"
    expect(page).to have_selector "h1", text: "Systemチーム2の選手一覧", exact_text: true
    # チーム一覧ページに遷移する
    click_link "別チームの情報を見る"
    expect(page).to have_selector "li", text: "Systemチーム1", exact_text: true
    expect(page).to have_selector "li", text: "Systemチーム2", exact_text: true
    # チーム詳細ページに遷移する
    click_link "Systemチーム2"
    expect(page).to have_selector "h1", text: "Systemチーム2の選手一覧", exact_text: true
  end
end
