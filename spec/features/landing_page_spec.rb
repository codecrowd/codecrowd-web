require 'spec_helper'

describe "landing page" do
  it "shows company name" do
    visit '/'
    within('body') { expect(page).to have_content('CodeCrowd') }
  end

  it "links to showroom"

  it "links to about" do
    Page.create(title: 'About', content: 'This is CodeCrowd', slug: 'about')
    visit '/'
    click_link 'About'
    expect(current_url).to eq(slug_url('about'))
  end
end
