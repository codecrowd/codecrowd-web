require 'spec_helper'

describe ApplicationHelper do
  it 'uses page title set in controller' do
    helper.stub(:page_title).and_return 'test title'
    expect(helper.yield_title_or_default).to eq 'test title'
  end

  it 'has default page title when not set' do
    helper.stub(:page_title).and_return nil
    expect(helper.yield_title_or_default).to eq described_class::PAGE_NAME
  end

end
