require 'rails_helper'

include Helpers

describe "Beer" do
  before :each do
    FactoryGirl.create :user
    FactoryGirl.create :beer
    FactoryGirl.create :brewery, name: "test"
    sign_in(username:"Pekka", password:"Foobar1")
    visit new_beer_path
  end

    it "can be created with right credentials" do
      fill_in('Name', with:'anonumous')

      expect{
        click_button('Create Beer')
      }.to change{Beer.count}.by(1)
    end

    it "and cannot be vreated if not has correct error name" do
      expect{
        click_button('Create Beer')
      }.to change{Beer.count}.by(0)

      expect(page).to have_content '1 error prohibited this beer from being saved:'
    end

end