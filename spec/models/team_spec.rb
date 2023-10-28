require "rails_helper"

RSpec.describe Team, type: :model do
  describe "validationのテスト" do
    let(:team) { build(:team, name:) }
    subject { team.valid? }

    context "nameカラム" do
      context "空欄のとき" do
        let(:name) { "" }
        it { is_expected.to eq false }
      end

      context "50文字以上のとき" do
        let(:name) { Faker::Lorem.characters(number: 51) }
        it { is_expected.to eq false }
      end

      context "1~50文字以下のとき" do
        let(:name) { Faker::Lorem.characters(number: rand(1..50)) }
        it { is_expected.to eq true }
      end
    end
  end
end
