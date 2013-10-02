require 'spec_helper'

describe "Pages" do

  describe "home page" do
    it "shows company name" do
      visit '/'
      within('body') { expect(page).to have_content('CodeCrowd') }
    end
  end

  describe "some page" do
    let!(:about_page) { Page.create(title: 'About', content: 'This is CodeCrowd', slug: 'about') }

    it "links to about" do
      visit '/'
      click_link 'About'
      expect(current_url).to eq(slug_url('about'))
    end

    it "has link back to root" do
      visit '/about'
      expect(find_link('CodeCrowd')[:href]).to eq '/'
    end

  end
end
