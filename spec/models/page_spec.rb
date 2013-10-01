require 'spec_helper'

describe Page do
  it 'can be found by slug' do
    existing_page = Page.create(title: 'something', content: 'some content', slug: 'about')
    page_found_by_slug = Page.find_by_slug 'about'
    expect(page_found_by_slug).to eq(existing_page)
  end
end
