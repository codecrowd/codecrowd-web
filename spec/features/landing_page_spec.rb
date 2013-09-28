describe "landing page" do
  it "has company name" do
    visit '/'
    expect(page).to have_content('CodeCrowd')
  end
end
