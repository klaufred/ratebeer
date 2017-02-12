require 'rails_helper'

RSpec.describe Beer, type: :model do
  describe "with correct parameters" do
    let(:beer){ FactoryGirl.create(:beer) }

    it "is saved" do
      expect(beer).to be_valid
      expect(Beer.count).to eq(1)
    end
  end

  it "is not saved without a name" do
    beer = Beer.new style:"IPA"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "is not saved without a style" do
    beer = Beer.new name:"test"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end
end
