describe "landing page" do
  before do
    visit '/'
  end

  it "shows company name" do
    expect(page).to have_content('CodeCrowd')
  end

  it "links to showroom"
end
