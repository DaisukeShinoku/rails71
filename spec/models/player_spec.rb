require "rails_helper"

RSpec.describe Player, type: :model do
  describe "validationのテスト" do
    subject { player.valid? }

    context "nameカラム" do
      let(:player) { build(:player, name:) }
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

    context "genderカラム" do
      let(:player) { build(:player, gender:) }
      context "空欄のとき" do
        let(:gender) { "" }
        it { is_expected.to eq false }
      end
      context "enumに設定された値のとき" do
        let(:gender) { "female" }
        it { is_expected.to eq true }
      end
    end
  end

  describe "associationのテスト" do
    subject { player.valid? }

    context "teamが存在しているとき" do
      let(:team) { create(:team) }
      let(:player) { build(:player, team:) }
      it { is_expected.to eq true }
    end
    context "teamモデルが存在していないとき" do
      let(:team) { nil }
      let(:player) { build(:player, team:) }
      it { is_expected.to eq false }
    end
  end

  describe "enumのテスト" do
    context "genderカラム" do
      context "enumに設定された値のとき" do
        it "正常に保存される" do
          expect(create(:player, gender: "female")).to be_valid
        end
      end
      context "enumに設定されていない値のとき" do
        it "ArgumentErrorになる" do
          expect do
            create(:player, gender: "hoge")
          end.to raise_error(ArgumentError)
        end
      end
    end
  end
end
