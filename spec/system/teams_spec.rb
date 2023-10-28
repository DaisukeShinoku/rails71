require "rails_helper"

RSpec.describe "Teams", type: :system do
  before do
    driven_by(:rack_test)
  end

  scenario "チームを作成する" do
    visit teams_url
    click_link "参加チーム新規登録"
    fill_in "Name", with: "テストチーム"
    click_button "Create Team"
    expect(page).to have_text("テストチーム")
  end
end
