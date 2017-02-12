require 'rails_helper'

describe "Beer" do
  before :each do
    FactoryGirl.create :beer
  end

  describe "can be created" do
    it " with right credentials" do
      visit new_beer_path
      fill_in('name', with:'anonumous')

      expect{
        click_button('Create Beer')
      }.to change{Beer.count}.by(1)
    end

    it "and if not has correct error name" do
      visit new_beer_path
      click_button('Create Beer')

      expect(page).to have_content '1 error prohibited this beer from being saved:'
    end
  end
end