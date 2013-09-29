describe "landing page" do
  before do
    visit '/'
  end

  it "shows company name" do
    within 'body' do
      expect(page).to have_content('CodeCrowd')
    end
  end

  it "links to showroom"
end
